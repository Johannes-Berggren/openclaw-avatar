#!/bin/bash
# OpenClaw Avatar - Interactive Setup Script

set -e

echo ""
echo "🧑‍💻 OpenClaw Avatar Setup"
echo "========================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check for required tools
command -v node >/dev/null 2>&1 || { echo -e "${RED}Error: Node.js is required but not installed.${NC}" >&2; exit 1; }
command -v npm >/dev/null 2>&1 || { echo -e "${RED}Error: npm is required but not installed.${NC}" >&2; exit 1; }

echo "This script will help you configure your avatar."
echo ""

# Step 1: API Keys
echo -e "${BLUE}Step 1: API Keys${NC}"
echo "─────────────────"
echo ""

if [ -f .env ]; then
    echo -e "${YELLOW}Found existing .env file.${NC}"
    read -p "Overwrite? (y/N): " overwrite
    if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
        echo "Keeping existing .env"
    else
        cp .env.example .env
    fi
else
    cp .env.example .env
fi

echo ""
echo "You'll need API keys from:"
echo "  • Simli (avatar video): https://simli.com/dashboard"
echo "  • ElevenLabs (voice):   https://elevenlabs.io"
echo ""

read -p "Enter your SIMLI_API_KEY: " simli_key
if [ -n "$simli_key" ]; then
    sed -i.bak "s/^SIMLI_API_KEY=.*/SIMLI_API_KEY=$simli_key/" .env
    rm -f .env.bak
fi

read -p "Enter your ELEVENLABS_API_KEY: " elevenlabs_key
if [ -n "$elevenlabs_key" ]; then
    sed -i.bak "s/^ELEVENLABS_API_KEY=.*/ELEVENLABS_API_KEY=$elevenlabs_key/" .env
    rm -f .env.bak
fi

echo ""
echo -e "${GREEN}✓ API keys saved to .env${NC}"
echo ""

# Step 2: Face ID
echo -e "${BLUE}Step 2: Simli Face ID${NC}"
echo "──────────────────────"
echo ""
echo "Get a Face ID from: https://simli.com/dashboard → Faces"
echo "  • Use a stock face OR upload your own"
echo "  • Copy the Face ID (looks like: 5514e24d-6086-46a3-ace4-6a7264e5cb7c)"
echo ""

if [ -f avatar.config.json ]; then
    echo -e "${YELLOW}Found existing avatar.config.json${NC}"
    read -p "Overwrite? (y/N): " overwrite_config
    if [[ ! "$overwrite_config" =~ ^[Yy]$ ]]; then
        echo "Keeping existing config"
    else
        cp avatar.config.example.json avatar.config.json
    fi
else
    cp avatar.config.example.json avatar.config.json
fi

read -p "Enter your Simli Face ID (or press Enter to skip): " face_id
if [ -n "$face_id" ]; then
    # Use node to update JSON properly
    node -e "
        const fs = require('fs');
        const config = JSON.parse(fs.readFileSync('avatar.config.json', 'utf8'));
        config.avatars[0].faceId = '$face_id';
        fs.writeFileSync('avatar.config.json', JSON.stringify(config, null, 2));
    "
    echo -e "${GREEN}✓ Face ID saved to avatar.config.json${NC}"
else
    echo -e "${YELLOW}⚠ Using placeholder Face ID - update avatar.config.json later${NC}"
fi

echo ""

# Step 3: Install dependencies
echo -e "${BLUE}Step 3: Install Dependencies${NC}"
echo "─────────────────────────────"
echo ""

read -p "Install npm dependencies now? (Y/n): " install_deps
if [[ ! "$install_deps" =~ ^[Nn]$ ]]; then
    npm install
    echo ""
    echo -e "${GREEN}✓ Dependencies installed${NC}"
fi

echo ""

# Done!
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}  Setup Complete! 🎉${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo ""
echo "To start your avatar:"
echo ""
echo -e "  ${BLUE}npm run dev${NC}"
echo ""
echo "Then open: http://localhost:5173"
echo ""

# Check if keys were set
if grep -q "^SIMLI_API_KEY=$" .env 2>/dev/null || grep -q "^ELEVENLABS_API_KEY=$" .env 2>/dev/null; then
    echo -e "${YELLOW}⚠ Warning: Some API keys are empty in .env${NC}"
    echo "  Edit .env to add your keys before starting."
    echo ""
fi

if grep -q "your-simli-face-id\|YOUR-SIMLI-FACE-ID" avatar.config.json 2>/dev/null; then
    echo -e "${YELLOW}⚠ Warning: Face ID not configured in avatar.config.json${NC}"
    echo "  Get a Face ID from https://simli.com/dashboard"
    echo ""
fi
