---
name: avatar
description: Interactive AI avatar with local audio playback and ElevenLabs TTS. Give your agent a face that speaks!
emoji: "🧑‍💻"
homepage: https://github.com/Johannes-Berggren/openclaw-avatar
metadata:
  openclaw:
    skillKey: avatar
    os: [macos, linux, windows]
    requires:
      bins: [node, npm]
      env: [ELEVENLABS_API_KEY]
    install:
      - npm install -g openclaw-avatar
    config:
      requiredEnv:
        - ELEVENLABS_API_KEY
      optionalEnv:
        - ELEVENLABS_VOICE_ID
        - SLACK_BOT_TOKEN
        - OPENCLAW_TOKEN
      example: |
        ELEVENLABS_API_KEY=your-elevenlabs-api-key
    cliHelp: |
      openclaw-avatar - Interactive AI avatar frontend

      Usage: openclaw-avatar [options]

      Starts the avatar server at http://localhost:5173
---

# Avatar Skill

Give your OpenClaw agent a face! Real-time lip-synced video avatar with text-to-speech.

## What It Does

- **Speaks your responses** — Agent replies are converted to speech via ElevenLabs
- **Detail panel** — Shows formatted text alongside spoken audio
- **Multi-language** — Supports different languages for speech and TTS

## Quick Setup

### 1. Get API Keys (5 minutes)

| Service | Get Key | Free Tier |
|---------|---------|-----------|
| [ElevenLabs](https://elevenlabs.io) | Profile → API Keys | ✅ 10k chars/month |


2. Click any stock face (or create your own)
3. Copy the **Face ID** (looks like: `5514e24d-6086-46a3-ace4-6a7264e5cb7c`)

### 3. Set Environment Variables

```bash
export ELEVENLABS_API_KEY="your-elevenlabs-api-key"
```

### 4. Create Config File

Create `avatar.config.json` in your working directory:

```json
{
  "avatars": [
    {
      "id": "default",
      "name": "Assistant",
      "voiceId": "21m00Tcm4TlvDq8ikWAM",
      "default": true
    }
  ]
}
```

### 5. Start

```bash
openclaw-avatar
# Open http://localhost:5173
```

## Response Format

When responding via avatar, structure your replies like this:

```
<spoken>
Brief conversational summary. This is read aloud.
No markdown, no formatting — just natural speech.
</spoken>
<detail>
## Full Details Here

- Bullet points work great
- **Bold** and *italic* supported
- Code blocks, tables, etc.
</detail>
```

### Guidelines

| Section | Purpose | Style |
|---------|---------|-------|
| `<spoken>` | Read aloud by avatar | Conversational, 1-3 sentences, NO markdown |
| `<detail>` | Displayed in side panel | Full markdown formatting |

### Example

**User asks**: "What's on my calendar today?"

```
<spoken>
You have three meetings today. A team standup at 9, product review at 2, and a one-on-one with Sarah at 4.
</spoken>
<detail>
## Today's Schedule

### 9:00 AM — Team Standup
- **Duration**: 15 min
- Engineering team sync

### 2:00 PM — Product Review
- **Duration**: 1 hour
- Q1 roadmap discussion

### 4:00 PM — 1:1 with Sarah
- **Duration**: 30 min
- Project timeline follow-up
</detail>
```

## Session Key

Avatar sessions use: `agent:main:avatar`

## Voice Options

The default voice is ElevenLabs' "Rachel" (`21m00Tcm4TlvDq8ikWAM`).

Find more voices at [elevenlabs.io/voices](https://elevenlabs.io/voices):
- Copy the Voice ID from any voice's page
- Update `voiceId` in your config

## Troubleshooting

| Issue | Fix |
|-------|-----|
| No audio | Check `ELEVENLABS_API_KEY` is correct |
| Can't connect to OpenClaw | Verify gateway is running (`openclaw status`) |

## More Info

See full documentation: [github.com/Johannes-Berggren/openclaw-avatar](https://github.com/Johannes-Berggren/openclaw-avatar)
