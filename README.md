# OpenClaw Avatar

Voice-and-text frontend for OpenClaw. Audio is played locally through the browser Web Audio API; no external avatar-video service is used.

## Setup

1. Install Node.js 18+ and run `npm install`.
2. Copy `.env.example` to `.env`; configure `ELEVENLABS_API_KEY` and, when required, `OPENCLAW_TOKEN`.
3. Optionally copy `avatar.config.example.json` to `avatar.config.json` to configure voices, languages, and integrations. Legacy `faceId` values are local profile identifiers only; no face-rendering API is called.
4. Run `npm run dev` and open http://localhost:5173. Click the page to enable audio playback.

`npm run build` builds the server and browser client. `npm run typecheck` checks server types; `npx tsc --noEmit -p tsconfig.client.json` checks the browser client.

Voice synthesis still uses ElevenLabs. Browser speech recognition, text replies, and optional Stream Deck controls are retained. Mute and interrupt operate on local audio.
