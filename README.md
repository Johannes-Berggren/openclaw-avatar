# OpenClaw Avatar

[![npm version](https://badge.fury.io/js/openclaw-avatar.svg)](https://www.npmjs.com/package/openclaw-avatar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Interactive AI avatar frontend for OpenClaw with real-time lip-synced video and text-to-speech.

![Avatar Demo](https://via.placeholder.com/800x400?text=Demo+GIF+Coming+Soon)

## Features

- 🎬 **Real-time avatar video** with lip sync via [Simli](https://simli.com)
- 🗣️ **Text-to-speech** responses via [ElevenLabs](https://elevenlabs.io)
- 🎤 **Speech recognition** input
- 🌍 **Multi-language** support
- 📝 **Detail panel** with markdown formatting
- 💬 **Slack/email** forwarding (optional)
- 🎛️ **Stream Deck** hardware control (optional)

## Quick Start

### Option 1: npx (Recommended)

```bash
# Run directly without installing
npx openclaw-avatar

# Or install globally
npm install -g openclaw-avatar
openclaw-avatar
```

### Option 2: Clone and Run

```bash
git clone https://github.com/Johannes-Berggren/openclaw-avatar.git
cd openclaw-avatar
npm install
npm run dev
```

Then open http://localhost:5173

## Setup Guide

### 1. Get Your API Keys

You'll need two API keys:

#### Simli (Avatar Video)

1. Sign up at [simli.com](https://simli.com)
2. Go to **Dashboard** → **API Keys**
3. Copy your API key

#### ElevenLabs (Text-to-Speech)

1. Sign up at [elevenlabs.io](https://elevenlabs.io)
2. Go to **Profile** (bottom left) → **API Keys**
3. Copy your API key

### 2. Get a Simli Face ID

The Face ID tells Simli which avatar to render:

1. In [Simli Dashboard](https://simli.com/dashboard), go to **Faces**
2. Either:
   - **Use a stock face**: Click any pre-made face → Copy the Face ID from the URL or details panel
   - **Create custom face**: Upload a photo → Wait for processing → Copy Face ID
3. The Face ID looks like: `5514e24d-6086-46a3-ace4-6a7264e5cb7c`

> 💡 **Tip**: Start with a stock face to test, then create a custom one later.

### 3. Configure Environment

```bash
cp .env.example .env
```

Edit `.env`:
```bash
SIMLI_API_KEY=your-simli-api-key
ELEVENLABS_API_KEY=your-elevenlabs-api-key
```

### 4. Configure Avatar

```bash
cp avatar.config.example.json avatar.config.json
```

Edit `avatar.config.json` and replace `your-simli-face-id`:
```json
{
  "avatars": [
    {
      "id": "default",
      "name": "Assistant",
      "faceId": "5514e24d-6086-46a3-ace4-6a7264e5cb7c",
      "voiceId": "21m00Tcm4TlvDq8ikWAM",
      "default": true
    }
  ]
}
```

> 💡 The default `voiceId` is ElevenLabs' "Rachel" voice. Find more voices at [elevenlabs.io/voices](https://elevenlabs.io/voices).

### 5. Start the Avatar

```bash
npm run dev
```

Open http://localhost:5173 🎉

## Configuration Reference

### Environment Variables (`.env`)

| Variable | Required | Description |
|----------|----------|-------------|
| `SIMLI_API_KEY` | ✅ | API key from [Simli](https://simli.com/dashboard) |
| `ELEVENLABS_API_KEY` | ✅ | API key from [ElevenLabs](https://elevenlabs.io) |
| `ELEVENLABS_VOICE_ID` | ❌ | Override voice ID (default: from config) |
| `SLACK_BOT_TOKEN` | ❌ | Enable Slack forwarding |
| `OPENCLAW_TOKEN` | ❌ | OpenClaw gateway auth token |

### Config File (`avatar.config.json`)

```json
{
  "app": {
    "name": "My Avatar",        // Display name
    "port": 5173                // Server port
  },
  "openclaw": {
    "gatewayUrl": "ws://127.0.0.1:18789"  // OpenClaw gateway WebSocket
  },
  "avatars": [
    {
      "id": "default",
      "name": "Assistant",
      "faceId": "your-simli-face-id",     // From Simli dashboard
      "voiceId": "21m00Tcm4TlvDq8ikWAM",  // ElevenLabs voice ID
      "default": true
    }
  ],
  "languages": [
    { "code": "en-US", "name": "English", "flag": "gb", "default": true },
    { "code": "nb-NO", "name": "Norsk", "flag": "no" }
  ],
  "integrations": {
    "slack": { "enabled": false },
    "email": { "enabled": false },
    "streamDeck": { "enabled": false }
  }
}
```

## OpenClaw Integration

The avatar connects to your OpenClaw gateway via WebSocket to send/receive messages.

### Response Format

When your agent responds to avatar queries, use this format:

```
<spoken>
A short conversational summary (1-3 sentences). Plain speech only.
</spoken>
<detail>
Full detailed response with **markdown** formatting.
</detail>
```

The `<spoken>` part is read aloud; `<detail>` appears in the side panel.

### Example

**User**: "What meetings do I have today?"

**Agent Response**:
```
<spoken>
You have three meetings today. Your first one is a team standup at 9 AM, then a product review at 2 PM, and finally a 1-on-1 with Sarah at 4 PM.
</spoken>
<detail>
## Today's Meetings

### 9:00 AM - Team Standup
- **Duration**: 15 minutes
- **Attendees**: Engineering team

### 2:00 PM - Product Review  
- **Duration**: 1 hour
- **Attendees**: Product, Design, Engineering leads

### 4:00 PM - 1:1 with Sarah
- **Duration**: 30 minutes
- **Notes**: Follow up on project timeline
</detail>
```

## Stream Deck (Optional)

Control your avatar with an Elgato Stream Deck:

1. Install optional dependencies:
   ```bash
   npm install @elgato-stream-deck/node canvas
   ```

2. Enable in `avatar.config.json`:
   ```json
   {
     "integrations": {
       "streamDeck": { "enabled": true }
     }
   }
   ```

3. Connect Stream Deck and restart the server

## Development

```bash
npm run dev        # Development server with hot reload
npm run build      # Build for production
npm start          # Start production server
npm run typecheck  # Type check without building
```

## Troubleshooting

### "Cannot connect to Simli"
- Verify your `SIMLI_API_KEY` is correct
- Check that the Face ID exists in your Simli dashboard
- Ensure you have an active Simli subscription

### "No audio playing"
- Verify your `ELEVENLABS_API_KEY` is correct
- Check browser console for errors
- Ensure your browser allows audio playback

### "Cannot connect to OpenClaw gateway"
- Verify OpenClaw is running: `openclaw status`
- Check `gatewayUrl` in config matches your setup
- Ensure `OPENCLAW_TOKEN` matches if auth is enabled

### Avatar video is laggy
- Check your internet connection
- Try a lower-resolution face in Simli
- Close other bandwidth-heavy applications

## License

MIT © [Johannes Berggren](https://github.com/Johannes-Berggren)
