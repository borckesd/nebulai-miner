#!/bin/bash

GIT_REPO_URL="https://github.com/borckesd/nebulai-miner.git"

echo "[1/8] Creating .gitignore..."
cat <<EOF > .gitignore
__pycache__/
*.pyc
*.log
token.txt
.env
EOF

echo "[2/8] Creating requirements.txt..."
cat <<EOF > requirements.txt
aiohttp
numpy
EOF

echo "[3/8] Creating README.md..."
cat <<EOF > README.md
# Nebulai Miner

An asynchronous Python script to run matrix computation tasks from the Nebulai Network platform.

---

## Description

This program fetches computation tasks from the Nebulai server, performs large matrix calculations in parallel, then submits the results back. It is suitable to run on a VPS with multiple tokens.

---

## Features

- Asynchronous using \`asyncio\` and \`aiohttp\` for efficient I/O  
- Matrix processing with \`numpy\` and multithreading  
- Supports multiple tokens running in parallel  
- Can run as a systemd service for automatic start on VPS boot

---

## Installation

1. Clone this repository:

   \`\`\`bash
   git clone https://github.com/borckesd/nebulai-miner.git
   cd nebulai-miner
   \`\`\`

2. Create and fill the \`token.txt\` file with your token (example with one token):

   \`\`\`
   your_single_token_here
   \`\`\`

3. Install dependencies:

   \`\`\`bash
   pip install -r requirements.txt
   \`\`\`

---

## How to Run

### Run manually

\`\`\`bash
python3 nebulai_miner.py
\`\`\`

### Run as a systemd service (recommended)

1. Create the service file:

   \`/etc/systemd/system/nebulai-miner.service\`

   \`\`\`ini
   [Unit]
   Description=Nebulai Miner Service
   After=network.target

   [Service]
   User=ubuntu
   WorkingDirectory=/home/ubuntu/nebulai-miner
   ExecStart=/usr/bin/python3 -u nebulai_miner.py
   Restart=always
   RestartSec=5
   StandardOutput=journal
   StandardError=journal

   [Install]
   WantedBy=multi-user.target
   \`\`\`

2. Reload systemd and start the service:

   \`\`\`bash
   sudo systemctl daemon-reload
   sudo systemctl enable nebulai-miner.service
   sudo systemctl start nebulai-miner.service
   \`\`\`

3. Check service status:

   \`\`\`bash
   sudo systemctl status nebulai-miner.service
   \`\`\`

---

## How to View Logs

To view the live output and logs from the running service:

\`\`\`bash
sudo journalctl -u nebulai-miner.service -f
\`\`\`

This command shows real-time logs (follow) from the \`nebulai-miner\` service.

---

## How to Stop and Manage the Service

- Stop the service:

\`\`\`bash
sudo systemctl stop nebulai-miner.service
\`\`\`

- Restart the service:

\`\`\`bash
sudo systemctl restart nebulai-miner.service
\`\`\`

- Disable auto-start on boot:

\`\`\`bash
sudo systemctl disable nebulai-miner.service
\`\`\`

- Enable auto-start on boot:

\`\`\`bash
sudo systemctl enable nebulai-miner.service
\`\`\`

---

## Important Notes

- The \`token.txt\` file **is not uploaded to GitHub** because it contains your secret tokens.  
- Make sure your token(s) are correctly set so the mining process runs properly.  
- Use a Python Virtual Environment (\`venv\`) for better dependency isolation if desired.

---

## License

MIT License

---

## Contact

If you have any questions, please contact the repository owner.
EOF

echo "[4/8] Initializing Git repository..."
git init
git add .
git commit -m "Initial commit for Nebulai Miner"

echo "[5/8] Adding GitHub remote..."
git remote add origin "$GIT_REPO_URL"

echo "[6/8] Pushing to GitHub..."
git branch -M main
git push -u origin main

echo "[7/8] Done! Check your repo at $GIT_REPO_URL"
