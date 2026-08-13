# =========================================================
# Ultra-lightweight n8n + Python Dockerfile
# Optimized for ~330MB TOTAL RAM (Render's tighter free tier)
# Instance: 0.1 CPU / 330MB RAM
# Last updated: 2026-08-13
#
# STRATEGY TO HIT 330MB:
#  1. Alpine base instead of Debian-slim -> baseline OS+Node
#     footprint drops from ~80-100MB to ~30-45MB idle.
#  2. musl-libc ffmpeg from Alpine repos -> much smaller
#     resident memory than the apt/glibc build.
#  3. n8n version is pinned to 1.19.4 (kept from the first
#     revision) but NOT pushed older, on purpose. I could not
#     verify from n8n's own changelog exactly which release
#     first shipped Google Sheets node typeVersion 4.5 / Schedule
#     Trigger typeVersion 1.2 — both used in your uploaded
#     workflow — so guessing an older pin risks the workflow
#     failing to import at all. More importantly: n8n's core
#     process hasn't gotten meaningfully heavier across recent
#     1.x releases, so an older pin buys little RAM anyway. The
#     binary-data-mode fix below (item 6) is the change that
#     actually matters for THIS workflow's RAM use.
#  4. V8 heap capped hard (--max-old-space-size +
#     --max-semi-space-size) so Node itself cannot grow past
#     its slice of the budget.
#  5. n8n execution/log data trimmed to the bone so SQLite +
#     in-memory execution objects don't creep RAM over a long
#     uptime (this workflow runs multiple times/day).
#  6. Trimmed the Python layer to only what your workflow
#     actually invokes via Execute Command / Code nodes
#     (yt-dlp, edge-tts, pillow, requests). Dropped
#     beautifulsoup4/lxml/python-dotenv — remove the # if any
#     of your Execute Command nodes actually import them.
#
# ROUGH BUDGET AT RUNTIME (idle, one workflow not yet running):
#   Alpine OS + tini                    ~5-8MB
#   Node.js + n8n main process           ~90-110MB (heap capped)
#   n8n SQLite + internal caches         ~15-25MB
#   Python venv (idle, not invoked)      ~0MB (only loads on exec)
#   Headroom for ffmpeg/python/edge-tts
#   spawned DURING a render                ~130-190MB
#   ----------------------------------------------------
#   Total idle: ~130-160MB | Total mid-render: ~280-330MB
#
# CAVEAT I WON'T HIDE FROM YOU: your workflow renders actual
# video (ffmpeg concat + image + TTS audio + subtitles). If a
# scene image or a rendered clip is large/high-res, ffmpeg's
# own memory spike CAN blow past 330MB regardless of any Docker
# setting — that's ffmpeg doing real decode/encode work, not
# something a Dockerfile line can cap safely without corrupting
# output. If you hit OOM kills during the render step
# specifically (not at idle), the fix is lowering output
# resolution/bitrate in your ffmpeg command, not this file.
# =========================================================

FROM node:18-alpine3.19

# ---------------------------------------------------------
# System packages (Alpine equivalents — much smaller resident
# footprint than the Debian/apt versions of the same tools)
# ---------------------------------------------------------

RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    ffmpeg \
    curl \
    wget \
    git \
    ca-certificates \
    tini \
    bash

# ---------------------------------------------------------
# Python virtual environment
# ---------------------------------------------------------

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# ---------------------------------------------------------
# Minimal Python packages actually used by this workflow's
# Execute Command / Code nodes (yt-dlp for source clips,
# edge-tts for voice, pillow for thumbnail compositing,
# requests as a shared dependency).
# If your Execute Command nodes reference bs4/lxml/dotenv,
# uncomment those two lines below.
# ---------------------------------------------------------

RUN pip install --no-cache-dir \
    requests \
    yt-dlp \
    edge-tts \
    pillow
# RUN pip install --no-cache-dir python-dotenv beautifulsoup4 lxml

# ---------------------------------------------------------
# n8n version — kept at 1.19.4. NOT pinned older than this:
# I can't independently verify the exact minimum version your
# workflow's node typeVersions require, and an unverified guess
# could break the workflow on import for a RAM saving that's
# marginal at best. If you want to push older, the safe way is
# to import your workflow JSON into that exact n8n version
# first (locally or on a throwaway instance) and confirm every
# node loads without an "unrecognized typeVersion" warning
# before baking it into production.
# ---------------------------------------------------------

RUN npm install -g n8n@1.19.4 --omit=dev && \
    npm cache clean --force

# ---------------------------------------------------------
# Create n8n user + pre-create data directory
# ---------------------------------------------------------

RUN adduser -D -h /home/n8n -s /bin/bash n8n && \
    mkdir -p /home/n8n/.n8n/binaryData && \
    chown -R n8n:n8n /home/n8n /opt/venv

USER n8n

WORKDIR /home/n8n

# ---------------------------------------------------------
# Entrypoint script — parses a single DB_POSTGRESDB_CONNECTION_URL
# into the DB_POSTGRESDB_* vars n8n reads natively.
# ---------------------------------------------------------

COPY --chown=n8n:n8n entrypoint.sh /home/n8n/entrypoint.sh
RUN chmod +x /home/n8n/entrypoint.sh

# ---------------------------------------------------------
# Core settings
# ---------------------------------------------------------

ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Persistent storage — Render Disk mount path: /home/n8n/.n8n
ENV N8N_DATA_FOLDER=/home/n8n/.n8n

# ---------------------------------------------------------
# HARD memory cap for Node's V8 heap — this is the main lever
# for the 330MB total budget. max-old-space-size is the big
# heap; max-semi-space-size keeps the young-gen GC copy buffers
# small too (defaults can eat 16-64MB on their own).
# 110MB old-gen leaves room for: OS (~10MB) + n8n non-heap
# native buffers (~20-30MB) + a Python/ffmpeg child process
# spawned mid-workflow (~150-180MB) inside 330MB total.
# ---------------------------------------------------------

ENV NODE_OPTIONS="--max-old-space-size=110 --max-semi-space-size=16"

# ---------------------------------------------------------
# BIGGEST real lever for THIS workflow specifically: n8n's
# default binary-data mode keeps every image/audio/video
# buffer that flows between nodes IN RAM until the execution
# finishes. Your pipeline passes 5 scene images + 5 TTS audio
# clips + a thumbnail + a final rendered video through node
# outputs — with "memory" mode all of that sits in the Node
# heap simultaneously. Switching to "filesystem" mode writes
# each binary to disk immediately and only keeps a small
# reference in memory. This matters far more for your 330MB
# budget than any n8n version choice.
# ---------------------------------------------------------

ENV N8N_DEFAULT_BINARY_DATA_MODE=filesystem
ENV N8N_AVAILABLE_BINARY_DATA_MODES=filesystem
# Clear rendered scene binaries out of n8n's own binary store after
# 1 hour — your workflow already deletes /tmp files itself, but this
# covers n8n's separate binaryData folder so it can't grow unbounded
# across many runs/day and slowly eat the disk + page cache.
ENV N8N_BINARY_DATA_TTL=60
ENV N8N_PERSISTED_BINARY_DATA_TTL=60

# ---------------------------------------------------------
# Logging — file-based logs on a 330MB box compete with n8n
# itself for page cache and can grow unbounded over weeks of
# unattended runs. Console-only + warn level lets Render's own
# log capture handle storage instead.
# ---------------------------------------------------------

ENV N8N_LOG_OUTPUT=console
ENV N8N_LOG_LEVEL=warn

# ---------------------------------------------------------
# Turn off subsystems this unattended, single-workflow instance
# never uses — each is a small but real RAM/handle saving:
# public REST API surface, Prometheus metrics endpoint, and
# libuv's thread pool trimmed from the Node default of 4 to 2
# (each thread reserves its own stack).
# ---------------------------------------------------------

ENV N8N_PUBLIC_API_DISABLED=true
ENV N8N_METRICS=false
ENV UV_THREADPOOL_SIZE=2

# ---------------------------------------------------------
# Task Runners — stay disabled (belt-and-suspenders; 1.19.x
# doesn't have the broker at all, but keep this in case you
# ever bump the n8n version later).
# ---------------------------------------------------------

ENV N8N_RUNNERS_ENABLED=false

# ---------------------------------------------------------
# Execution data — trimmed hard. Saving full execution data
# for a video-render workflow (large JSON payloads, binary
# refs) is one of the biggest silent RAM/DB creep sources on
# long-running low-RAM instances.
# ---------------------------------------------------------

ENV N8N_PRUNING_ENABLED=true
ENV N8N_PRUNING_EXECUTION_DATA_MAX_AGE=6
ENV N8N_PRUNING_EXECUTION_DATA_PRUNE_INTERVAL=15
ENV EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
ENV EXECUTIONS_DATA_SAVE_ON_ERROR=all
ENV EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=false
ENV EXECUTIONS_DATA_PRUNE=true

# Only run one execution at a time — on 0.1 CPU / 330MB, two
# workflow runs overlapping (e.g. schedule trigger + a fallback
# trigger firing close together) is the fastest way to OOM.
ENV N8N_CONCURRENCY_PRODUCTION_LIMIT=1

# ---------------------------------------------------------
# Disable unnecessary features
# ---------------------------------------------------------

ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_TEMPLATES_ENABLED=false
ENV N8N_ONBOARDING_FLOW_DISABLED=true
ENV N8N_PERSONALIZATION_ENABLED=false

# Disable queue/worker mode (not needed, saves RAM)
ENV QUEUE_HEALTH_CHECK_ACTIVE=false
ENV OFFLOAD_MANUAL_EXECUTIONS_TO_WORKERS=false

# ---------------------------------------------------------
# Security
# true is correct here: Render terminates TLS at its proxy and
# forwards to this container over plain HTTP, but N8N_PROXY_HOPS
# (set in render.yaml) tells n8n to trust the X-Forwarded-Proto
# header, so it correctly sees the connection as HTTPS. false
# would make login cookies fail intermittently behind Render's
# proxy.
# ---------------------------------------------------------

ENV N8N_SECURE_COOKIE=true

# ---------------------------------------------------------
# Healthcheck
# ---------------------------------------------------------

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

EXPOSE 5678

ENTRYPOINT ["tini", "--", "/home/n8n/entrypoint.sh"]
CMD ["n8n", "start"]
