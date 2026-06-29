FROM node:20-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
RUN apt-get update && \
apt-get install -y --no-install-recommends \
ffmpeg \
python3 \
python3-pip \
python3-venv \
python3-dev \
build-essential \
curl \
wget \
git \
bash \
nano \
vim \
jq \
zip \
unzip \
tar \
gzip \
ca-certificates \
imagemagick \
ghostscript \
tesseract-ocr \
mediainfo \
sox && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Create Python virtual environment
RUN python3 -m venv /opt/venv

# Activate venv globally
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip tools
RUN pip install --upgrade pip setuptools wheel

# Install Python packages
RUN pip install --no-cache-dir \
edge-tts \
yt-dlp \
requests \
pandas \
numpy \
pillow \
moviepy \
openpyxl \
beautifulsoup4 \
lxml \
python-dotenv \
n8n-python

# Install n8n
RUN npm install -g n8n

# Install Python runner support
RUN npm install -g @n8n/task-runner-python

# Create n8n user
RUN useradd -m -s /bin/bash n8n

# Permissions
RUN chown -R n8n:n8n /opt/venv

USER n8n

WORKDIR /home/n8n

# n8n settings
ENV N8N_PORT=5678

# Enable task runners
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_RUNNERS_MODE=internal
ENV N8N_RUNNERS_PYTHON_ENABLED=true

# Python path
ENV PYTHON_EXECUTABLE=/opt/venv/bin/python

EXPOSE 5678

CMD ["n8n", "start"]
