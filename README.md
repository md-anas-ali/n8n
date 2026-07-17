<div align="center">

# 🚀 n8🚀 n8n Ultimate Free Deployment

«Production-ready n8n deployment using Docker, Render, and External PostgreSQL.»

"Docker" (https://img.shields.io/badge/Docker-Ready-blue)
"n8n" (https://img.shields.io/badge/n8n-Latest-orange)
"PostgreSQL" (https://img.shields.io/badge/PostgreSQL-Supported-blue)
"Render" (https://img.shields.io/badge/Render-Free-success)

---

✨ Features

- 🚀 Deploy n8n on Render
- 🐳 Custom Dockerfile support
- 🐘 External PostgreSQL support
- 🔒 Secure Environment Variables
- 💾 Persistent workflows & credentials
- 🎬 FFmpeg pre-installed
- 🐍 Python support
- 📦 yt-dlp pre-installed
- ⚡ Optimized for low-memory servers
- 🔄 GitHub Auto Deploy
- 🌍 Custom Domain support
- 🛡 Production-ready configuration

---

📦 Included

- n8n
- Docker
- FFmpeg
- Python 3
- yt-dlp
- curl
- wget
- Git

---

🗄 Supported Databases

- ✅ Neon PostgreSQL
- ✅ Supabase PostgreSQL
- ✅ PostgreSQL Compatible Servers

---

☁ Supported Hosting

- Render
- VPS
- Railway
- Coolify
- Docker
- Docker Compose

---

🚀 Quick Deploy

1. Fork this repository.
2. Create a Render Web Service.
3. Connect your GitHub repository.
4. Add the required Environment Variables.
5. Deploy.

---

🔐 Required Environment Variables

Host

N8N_HOST=
N8N_PROTOCOL=https
N8N_PORT=5678
WEBHOOK_URL=
N8N_EDITOR_BASE_URL=

PostgreSQL

DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=
DB_POSTGRESDB_USER=
DB_POSTGRESDB_PASSWORD=
DB_POSTGRESDB_SSL_ENABLED=true

Security

N8N_ENCRYPTION_KEY=

«Never change the encryption key after the first deployment.»

---

📂 Data Persistence

When using PostgreSQL:

- ✅ Workflows remain safe
- ✅ Credentials remain safe
- ✅ Settings remain safe
- ✅ Users remain safe

Even if Render restarts or redeploys, your data remains in PostgreSQL.

---

📁 Dockerfile

The Docker image already includes:

- FFmpeg
- Python
- yt-dlp
- Node.js
- n8n

You can easily install additional packages inside the Dockerfile.

---

⚡ Performance

Optimized for:

- Render Free
- 512MB RAM
- Low CPU
- Production usage

---

🔄 Auto Deploy

Every push to the main branch automatically triggers a new deployment on Render.

---

🛠 Troubleshooting

Database Connection Error

- Verify PostgreSQL credentials.
- Ensure SSL is enabled.
- Confirm the host and port.

---

Lost Workflows

Check:

- DB_TYPE
- PostgreSQL connection
- N8N_ENCRYPTION_KEY

---

Render Restart

No problem.

If the same PostgreSQL database and the same encryption key are used, all workflows, credentials, users, and settings remain available.

---

📌 Best Practices

- Keep your encryption key safe.
- Store secrets only in Render Environment Variables.
- Never commit passwords to GitHub.
- Use an external PostgreSQL database.
- Enable execution pruning.

---

📜 License

This repository contains deployment configuration and examples.

Please review the licenses of all included software (such as n8n and any installed dependencies) before using them in production.

---

❤️ Contributing

Issues and pull requests are welcome.

---

⭐ Support

If this project helps you, consider giving it a ⭐ on GitHub. Self-Hosted with Custom Dependencies

### Free Forever Stack + Custom Dockerfile Template

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
[![n8n](https://img.shields.io/badge/n8n-v2.2.4-orange)](https://n8n.io)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-Sustainable%20Use-green)](https://github.com/n8n-io/n8n/blob/master/LICENSE.md)

**A complete guide to self-hosting n8n with custom dependencies for free, featuring a customizable Dockerfile template for advanced automation workflows.**

[Quick Start](#-quick-start) • [Custom Dockerfile](#-custom-dockerfile-template) • [Use Cases](#-advanced-use-cases) • [Troubleshooting](#-troubleshooting)

---

</div>

## 👋 About This Guide

**Written by [Laksh](https://instagram.com/lakshpujary)**

After countless hours of trial and error, I finally cracked the code to running n8n completely free with custom dependencies. This isn't just another basic n8n setup guide—it's a **template for building your own custom n8n instance** with whatever tools, libraries, or dependencies your workflows need.

Whether you're building AI avatar workflows, custom automation pipelines, or need specific Python packages—this guide has you covered.

📱 **Follow me**: [@lakshpujary](https://instagram.com/lakshpujary) for more automation content

---

## 🎯 What Makes This Different?

Most n8n guides show you how to use the standard Docker image. **This guide teaches you how to extend it.**

### Why Customize Your n8n Dockerfile?

The standard n8n image is powerful, but it doesn't include everything. If you need:

- 🎭 **AI Avatar & Lip-Sync Tools**: ffmpeg, face detection libraries, audio processing
- 🐍 **Custom Python Packages**: Specific ML/AI libraries, data processing tools
- 🎬 **Media Processing**: Video editing, transcoding, format conversion
- 🛠️ **System Utilities**: Command-line tools, compilers, additional languages
- 📦 **Niche Dependencies**: Industry-specific software or libraries

Then you need a **custom Dockerfile**—and that's exactly what this template provides.

---

## 🏗️ The Stack

This setup solves three major problems with self-hosting n8n:

| Problem | Solution | Why It Works |
|---------|----------|--------------|
| ❌ Data loss on restart | ✅ Supabase (external Postgres) | Workflows persist forever |
| ❌ Service goes to sleep | ✅ UptimeRobot | Pings every 5 min, keeps it awake |
| ❌ Missing dependencies | ✅ Custom Dockerfile | Install anything you need |

### Tech Stack:
- **[Render](https://render.com)** - Free Docker hosting (750 hrs/month)
- **[Supabase](https://supabase.com)** - Managed PostgreSQL (500MB free)
- **[UptimeRobot](https://uptimerobot.com)** - Keep-alive monitoring (50 monitors free)

**Total Cost: $0/month** 💰

---

## 🎬 Advanced Use Cases

### What You Can Build With Custom Dependencies

#### 1. AI Avatar Workflows (Live Face Animation)
```dockerfile
# Add face detection and lip-sync tools
RUN apt-get install -y ffmpeg python3-opencv
RUN pip3 install --break-system-packages face-recognition pydub
```
**Use Case**: Automated video generation with AI avatars that speak your content

#### 2. Advanced Media Processing
```dockerfile
# Add video editing and transcoding
RUN apt-get install -y ffmpeg imagemagick ghostscript
RUN pip3 install --break-system-packages moviepy pillow
```
**Use Case**: Automated video editing, thumbnail generation, format conversion

#### 3. Data Science Workflows
```dockerfile
# Add ML/AI libraries
RUN pip3 install --break-system-packages pandas numpy scikit-learn tensorflow
```
**Use Case**: Automated data analysis, ML model inference, predictions

#### 4. Web Scraping at Scale
```dockerfile
# Add headless browser support
RUN apt-get install -y chromium-browser chromium-chromedriver
RUN pip3 install --break-system-packages selenium beautifulsoup4
```
**Use Case**: Complex web scraping, automated testing, data extraction

---

## 🛠️ Custom Dockerfile Template

This is the heart of the setup. The Dockerfile in this repo is **pre-configured with:**

```dockerfile
FROM node:20-bookworm-slim

# Install system dependencies
RUN apt-get update \
  && apt-get install -y ffmpeg python3 python3-pip ca-certificates curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install yt-dlp (media downloader)
RUN pip3 install --break-system-packages --no-cache-dir yt-dlp

# Install n8n
RUN npm install -g n8n

# Create n8n user
RUN useradd -m n8n

# Set working directory
WORKDIR /home/n8n

# Switch to n8n user
USER n8n

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
```

### 🎨 Customize It for Your Needs

Want to add your own dependencies? Here's how:

**Example: Adding Machine Learning Tools**
```dockerfile
# After the system dependencies section, add:
RUN apt-get install -y python3-dev build-essential

# After the pip install section, add:
RUN pip3 install --break-system-packages \
    tensorflow \
    torch \
    opencv-python \
    scikit-learn
```

**Example: Adding Ruby Support**
```dockerfile
# Add Ruby runtime
RUN apt-get install -y ruby-full
RUN gem install nokogiri httparty
```

**Example: Adding Go Binaries**
```dockerfile
# Install Go
RUN wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz \
  && tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
```

---

## 📋 Prerequisites

Create free accounts on:
1. 🔵 **[Render](https://render.com)** - Docker web service hosting
2. 🟢 **[Supabase](https://supabase.com)** - Managed PostgreSQL database
3. 🔴 **[UptimeRobot](https://uptimerobot.com)** - Service monitoring

---

## 🚀 Quick Start

### Step 1: Set Up Supabase Database

1. Log into Supabase → **New Project**
2. Set a strong database password 🔐 (save this!)
3. Wait for project provisioning (~2 minutes)
4. Go to **Project Settings → Database**
5. Copy your **Session Pooler** connection details:

```
Host: aws-1-us-east-1.pooler.supabase.com
Port: 5432
Database: postgres
User: postgres.<your-project-id>
Password: <your-password>
```

> ⚡ **Pro Tip**: Always use the Session Pooler, not the direct connection. It handles connection limits much better.

---

### Step 2: Fork & Deploy to Render

#### Option A: One-Click Deploy (Recommended)

1. **Fork this repository** to your GitHub account
2. Click the Deploy to Render button above
3. Render will auto-detect `render.yaml` and configure everything
4. Add your environment variables (see Step 3)
5. Deploy! 🎉

#### Option B: Manual Setup

1. Log into Render → **New → Web Service**
2. Connect your forked repository
3. Configure:
   ```
   Name: n8n-custom
   Region: Virginia (US East)
   Branch: main
   Runtime: Docker
   Dockerfile Path: ./Dockerfile
   ```
4. Click **Create Web Service**

---

### Step 3: Configure Environment Variables

In Render dashboard → **Environment** tab, add these:

#### 🗄️ Database (Supabase)
```bash
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=aws-1-us-east-1.pooler.supabase.com
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres.<your-project-id>
DB_POSTGRESDB_PASSWORD=<your-supabase-password>
DB_POSTGRESDB_SSL=true
DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false
```

#### 🌐 n8n Configuration
```bash
N8N_HOST=<your-app>.onrender.com
N8N_PORT=5678
N8N_PROTOCOL=https
N8N_EDITOR_BASE_URL=https://<your-app>.onrender.com
WEBHOOK_URL=https://<your-app>.onrender.com/
```

#### 🔐 Security
```bash
N8N_ENCRYPTION_KEY=<generate-a-random-32-char-string>
N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
N8N_BLOCK_ENV_ACCESS_IN_NODE=false
N8N_RUNNERS_ENABLED=true
N8N_TRUSTED_PROXIES=0.0.0.0/0
```

> 🚨 **CRITICAL**: Never change `N8N_ENCRYPTION_KEY` after first deployment. Store it safely!

**Generate Encryption Key:**
```bash
openssl rand -base64 32
```

---

### Step 4: Custom Domain (Optional but Recommended)

Make your instance accessible at `n8n.yourdomain.com`:

1. Render → **Settings → Custom Domain** → Add `n8n.yourdomain.com`
2. Render provides a CNAME target
3. In your DNS provider (Cloudflare, Namecheap, etc.):
   ```
   Type: CNAME
   Name: n8n
   Target: <your-app>.onrender.com
   TTL: 3600
   ```
4. Update environment variables:
   ```bash
   N8N_HOST=n8n.yourdomain.com
   N8N_EDITOR_BASE_URL=https://n8n.yourdomain.com
   WEBHOOK_URL=https://n8n.yourdomain.com/
   ```
5. **Redeploy** the service

DNS propagation takes 5-30 minutes ⏱️

---

### Step 5: Keep It Awake (UptimeRobot)

Render free tier idles after 15 minutes. UptimeRobot prevents this:

1. UptimeRobot → **Add New Monitor**
2. Configure:
   ```
   Monitor Type: HTTP(s)
   Friendly Name: n8n-keepalive
   URL: https://<your-app>.onrender.com
   Interval: 5 minutes
   ```
3. **Create Monitor**

Your instance now stays awake 24/7! 🌟

---

## 🎨 What's Included Out of the Box

This custom image comes pre-loaded with:

| Tool | Purpose | Use Cases |
|------|---------|-----------|
| **ffmpeg** | Video/audio processing | Transcoding, format conversion, streaming |
| **Python 3** | Scripting runtime | Custom logic, data processing, ML inference |
| **yt-dlp** | Media downloader | Download from 1000+ sites including YouTube |
| **curl** | HTTP client | API testing, file downloads |
| **ca-certificates** | SSL support | Secure connections |

### Example Workflows You Can Build:

✅ **Video Processing Pipeline**
- Download videos from YouTube
- Extract audio tracks
- Convert to different formats
- Upload to cloud storage
- Generate thumbnails

✅ **AI Content Generation**
- Text-to-speech with lip-sync
- Automated video editing
- Face detection and processing
- Batch media processing

✅ **Data Automation**
- Web scraping with custom tools
- Data transformation with Python
- Scheduled API integrations
- Automated reporting

---

## 🔍 Troubleshooting

### ⚠️ Database Connection Timeouts

**Symptoms:**
```
Database connection timed out
503 Database is not ready!
```

**Solutions:**
1. ✅ Verify Supabase credentials are correct (check for typos!)
2. ✅ Ensure you're using **Session Pooler**, not direct connection
3. ✅ Check region match: Render = Virginia, Supabase = US-East
4. ✅ Verify `DB_POSTGRESDB_SSL=true` is set

---

### ⚠️ Service Won't Start

**Check:**
- 📋 All environment variables are set
- 🔑 `N8N_ENCRYPTION_KEY` is configured
- 📝 Review logs: Render dashboard → Logs tab
- 🐛 Check Dockerfile syntax if you modified it

---

### ⚠️ Workflows Lost After Restart

**This means database isn't connected:**
- ✅ Verify `DB_TYPE=postgresdb`
- ✅ Check all `DB_POSTGRESDB_*` variables
- ✅ Look for connection errors in logs
- ✅ Test Supabase connection separately

---

### ⚠️ Custom Dependencies Not Working

**If your added packages don't work:**
- 🔧 Check Dockerfile syntax
- 📦 Verify package names are correct
- 🏗️ Rebuild: Clear cache → Manual Deploy
- 📝 Check build logs for errors

---

## 📊 Performance Metrics

| Metric | Value | Notes |
|--------|-------|-------|
| Cold Start | 30-60s | First request after idle |
| Warm Response | <500ms | Subsequent requests |
| DB Latency | 20-50ms | Same-region (Virginia ↔ US-East) |
| Uptime | 99.9%+ | With UptimeRobot configured |
| Storage | 500MB | Supabase free tier |
| Compute | 750hrs/mo | Render free tier |

---

## 🎯 Best Practices

### Do's ✅
- ✅ **Always backup** your `N8N_ENCRYPTION_KEY`
- ✅ **Use Session Pooler** for Supabase connections
- ✅ **Set up UptimeRobot** before going live
- ✅ **Test workflows** after any Dockerfile changes
- ✅ **Enable data pruning** to keep DB size manageable
- ✅ **Match regions** (Render + Supabase)

### Don'ts ❌
- ❌ Don't change encryption key after first deployment
- ❌ Don't use direct Supabase connection (use pooler)
- ❌ Don't skip UptimeRobot (service will sleep)
- ❌ Don't add unnecessary dependencies (bloats image)
- ❌ Don't forget to rebuild after Dockerfile changes

---

## 🚨 Common Mistakes & Fixes

| Mistake | Impact | Fix |
|---------|--------|-----|
| Wrong Supabase connection type | Timeouts, errors | Use Session Pooler |
| Missing encryption key | Can't decrypt credentials | Set before first run |
| Mismatched regions | High latency, timeouts | Use Virginia + US-East |
| No UptimeRobot | Service sleeps, delays | Set 5-min monitoring |
| Typos in env vars | Service won't start | Double-check everything |

---

## 🎓 Learning Resources

- 📖 [n8n Official Docs](https://docs.n8n.io/)
- 💬 [n8n Community Forum](https://community.n8n.io/)
- 🎥 [n8n YouTube Channel](https://www.youtube.com/@n8n-io)
- 📦 [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- 🐘 [Supabase Documentation](https://supabase.com/docs)

---

## 🤝 Contributing

Found a better approach? Have a cool custom Dockerfile example? Contributions welcome!

1. Fork this repo
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

This setup guide is open-source and provided as-is.  
n8n is licensed under the [Sustainable Use License](https://github.com/n8n-io/n8n/blob/master/LICENSE.md).

---

<div align="center">

## 💫 Built by the Community, for the Community

**Created by [@lakshpujary](https://instagram.com/lakshpujary)**

If this guide helped you save time and money, consider:
- ⭐ Starring this repository
- 📱 Following me on [Instagram](https://instagram.com/lakshpujary)
- 🔄 Sharing with others who need it

---

### Made with ❤️ for the n8n automation community

</div>
