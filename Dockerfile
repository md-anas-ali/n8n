# =========================================================
# Lightweight n8n + Python Dockerfile
# Optimized for Render Free Plan
# Instance: 0.1 CPU / 512MB RAM
# =========================================================

FROM node:20-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# ---------------------------------------------------------
# System packages
# ---------------------------------------------------------

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    curl \
    wget \
    git \
    ca-certificates \
    tini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------
# Python virtual environment
# ---------------------------------------------------------

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

# ---------------------------------------------------------
# Upgrade pip
# ---------------------------------------------------------

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# ---------------------------------------------------------
# Lightweight Python packages
# Optimized for low RAM
# ---------------------------------------------------------

RUN pip install --no-cache-dir \
    requests \
    python-dotenv \
    yt-dlp \
    edge-tts \
    pillow \
    beautifulsoup4 \
    lxml

# ---------------------------------------------------------
# Install stable n8n version
# Node.js 20 compatible (22+ required for newer n8n)
# ---------------------------------------------------------

RUN npm install -g n8n@1.95.3

# ---------------------------------------------------------
# Create n8n user + pre-create data directory
# ---------------------------------------------------------

RUN useradd -m -s /bin/bash n8n && \
    mkdir -p /home/n8n/.n8n && \
    chown -R n8n:n8n /home/n8n /opt/venv

USER n8n

WORKDIR /home/n8n

# ---------------------------------------------------------
# Core settings
# ---------------------------------------------------------

ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Persistent storage — Render Disk: /home/n8n/.n8n
ENV N8N_DATA_FOLDER=/home/n8n/.n8n

# ---------------------------------------------------------
# Memory optimization (512MB RAM)
# ---------------------------------------------------------

ENV NODE_OPTIONS=--max-old-space-size=256
ENV EXECUTIONS_PROCESS=main

# Auto cleanup old executions
ENV N8N_PRUNING_ENABLED=true
ENV N8N_PRUNING_EXECUTION_DATA_MAX_AGE=24

# ---------------------------------------------------------
# Disable unnecessary features
# ---------------------------------------------------------

ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_TEMPLATES_ENABLED=false

# Disable task runners — 512MB RAM-এ reliable না
# N8N_RUNNERS_ENABLED is the confirmed variable for n8n 1.95.3
ENV N8N_RUNNERS_ENABLED=false

# Disable queue/worker features (not needed, saves RAM)
ENV QUEUE_HEALTH_CHECK_ACTIVE=false
ENV OFFLOAD_MANUAL_EXECUTIONS_TO_WORKERS=false

# ---------------------------------------------------------
# Security
# ---------------------------------------------------------

ENV N8N_SECURE_COOKIE=false

# ---------------------------------------------------------
# Healthcheck
# ---------------------------------------------------------

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# ---------------------------------------------------------
# Expose port
# ---------------------------------------------------------

EXPOSE 5678

# ---------------------------------------------------------
# Start n8n
# ---------------------------------------------------------

CMD ["tini", "--", "n8n", "start"]
