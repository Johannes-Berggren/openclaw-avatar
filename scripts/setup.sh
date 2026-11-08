#!/bin/bash
set -euo pipefail
command -v node >/dev/null
command -v npm >/dev/null
if [ ! -f .env ]; then cp .env.example .env; chmod 600 .env; fi
if [ ! -f avatar.config.json ]; then cp avatar.config.example.json avatar.config.json; fi
echo "Edit .env to configure ELEVENLABS_API_KEY and OPENCLAW_TOKEN."
npm install
echo "Start with npm run dev, then open http://localhost:5173."
