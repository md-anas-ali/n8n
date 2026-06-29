FROM node:20-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
apt-get install -y --no-install-recommends \
ffmpeg \
python3 \
python3-pip \
python3-venv \
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

RUN python3 -m pip install --upgrade pip --break-system-packages

RUN pip3 install --break-system-packages --no-cache-dir \
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
python-dotenv

RUN npm install -g n8n

RUN useradd -m -s /bin/bash n8n

USER n8n

WORKDIR /home/n8n

ENV N8N_PORT=5678

EXPOSE 5678

CMD ["n8n","start"]
