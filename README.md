🚀 n8n Ultimate Free Deployment

Production-ready n8n deployment with Docker, Render, and External PostgreSQL.

«Deploy once. Keep your workflows, credentials, and settings safe with an external PostgreSQL database.»

---

✨ Features

- 🚀 Render deployment
- 🐳 Custom Dockerfile
- 🐘 External PostgreSQL support
- 🔒 Secure Environment Variables
- 💾 Persistent workflows
- 🔑 Persistent credentials
- 👤 Persistent users
- ⚙ Persistent settings
- 🎬 FFmpeg included
- 🐍 Python included
- 📦 yt-dlp included
- 🎤 Edge-TTS included
- 🖼 Pillow included
- 🌐 BeautifulSoup4 included
- ⚡ Low-memory optimized
- 🔄 GitHub Auto Deploy
- 🌍 Custom Domain support

---

📦 Included Software

- n8n
- Node.js
- Python 3
- FFmpeg
- yt-dlp
- Edge-TTS
- Pillow
- BeautifulSoup4
- lxml
- Git
- curl
- wget

---

🗄 Supported Databases

- PostgreSQL
- Neon PostgreSQL
- Supabase PostgreSQL
- Any PostgreSQL-compatible provider

---

☁ Supported Platforms

- Render
- VPS
- Docker
- Docker Compose
- Railway
- Coolify

---

🚀 Deployment

1. Fork this repository.
2. Create a new Render Web Service.
3. Connect your GitHub repository.
4. Add all required Environment Variables.
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

💾 Persistent Data

When PostgreSQL is configured:

- ✅ Workflows
- ✅ Credentials
- ✅ Users
- ✅ Variables
- ✅ Settings
- ✅ Tags
- ✅ Projects

remain stored inside the PostgreSQL database.

Even if Render restarts or redeploys the service, the data remains available as long as the same PostgreSQL database and the same "N8N_ENCRYPTION_KEY" are used.

---

🐳 Docker Image

The Docker image includes:

- Python
- FFmpeg
- yt-dlp
- Edge-TTS
- Pillow
- BeautifulSoup4
- lxml

You can install additional Linux packages or Python libraries by editing the Dockerfile.

---

⚡ Optimized For

- Render Free
- 512 MB RAM
- Low CPU usage
- Long-running workflows

---

🔄 Automatic Deployment

Every push to the "main" branch automatically deploys the latest version on Render (if Auto Deploy is enabled).

---

🛠 Troubleshooting

Database Connection Error

Verify:

- Database host
- Database user
- Database password
- SSL configuration

---

Credentials Not Working

Check:

- "N8N_ENCRYPTION_KEY"

Changing the encryption key after deployment will prevent existing credentials from being decrypted.

---

Missing Workflows

Verify:

- "DB_TYPE=postgresdb"
- PostgreSQL connection
- Database credentials

---

Render Restart

Render may restart or redeploy your service.

If you continue using:

- the same PostgreSQL database
- the same "N8N_ENCRYPTION_KEY"

your workflows, credentials, users, and settings will still be available.

---

📁 Repository Structure

.
├── Dockerfile
├── render.yaml
├── README.md
├── .gitignore
└── .env.example

---

🔒 Security

Never commit:

- ".env"
- Database passwords
- API keys
- Encryption keys

Store all secrets in Render Environment Variables.

---

📄 License

Review the licenses of n8n and any bundled dependencies before production use.

---

🤝 Contributing

Contributions, pull requests, and issue reports are welcome.

---

⭐ Support

If this repository helps you, consider giving it a ⭐ on GitHub.
