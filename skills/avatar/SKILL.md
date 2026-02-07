# Avatar Skill

This skill provides an interactive AI avatar interface for OpenClaw. The avatar can speak responses using text-to-speech and display detailed information in a sidebar panel.

## Capabilities

- **Voice Responses**: The avatar speaks conversational summaries using ElevenLabs TTS
- **Visual Avatar**: Rendered using Simli for realistic lip-synced video
- **Detail Panel**: Shows formatted markdown content alongside spoken responses
- **Multi-language**: Supports multiple languages for speech recognition and TTS
- **Slack Integration**: Can send messages to Slack DMs (when configured)
- **Email Integration**: Can forward content via email (when configured)
- **Stream Deck**: Optional hardware control with Elgato Stream Deck

## Response Format

When responding to avatar queries, use this exact format:

```
<spoken>
A short conversational summary (1-3 sentences). NO markdown, NO bullet points, NO formatting. Plain speech only.
</spoken>
<detail>
The full detailed response with markdown formatting (bullet points, headers, bold, etc).
</detail>
```

### Guidelines

1. **spoken section**: Keep it brief, natural, and conversational. This will be read aloud.
2. **detail section**: Include comprehensive information with proper markdown formatting.
3. Always include both sections, even for simple responses.

## Example

User: "What meetings do I have today?"

Response:
```
<spoken>
You have three meetings today. Your first one is a team standup at 9 AM, then a product review at 2 PM, and finally a 1-on-1 with Sarah at 4 PM.
</spoken>
<detail>
## Today's Meetings

### 9:00 AM - Team Standup
- **Duration**: 15 minutes
- **Attendees**: Engineering team
- **Location**: Zoom

### 2:00 PM - Product Review
- **Duration**: 1 hour
- **Attendees**: Product, Design, Engineering leads
- **Location**: Conference Room A
- **Agenda**: Q2 roadmap discussion

### 4:00 PM - 1:1 with Sarah
- **Duration**: 30 minutes
- **Attendees**: You, Sarah Chen
- **Location**: Your office
- **Notes**: Follow up on project timeline
</detail>
```

## Available Tools

The avatar has access to all OpenClaw tools and integrations. Common ones include:

- HubSpot (CRM, contacts, deals)
- Gmail (email)
- Google Calendar (events, scheduling)
- Notion (documents, databases)
- Slack (messaging)

## Session Key

Avatar responses use the session key: `agent:main:avatar`
