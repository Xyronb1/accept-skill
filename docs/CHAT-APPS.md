# Using /accept in ChatGPT and Claude chat

🌐 **English** · [Türkçe](CHAT-APPS.tr.md)

`/accept` works in two ways:

- **Claude Code** (terminal / desktop Code tab): installed as a skill, see [INSTALL.md](INSTALL.md). There `/accept` is a real command.
- **ChatGPT and Claude (regular chat / web / app):** you give the model the text of a universal prompt once; after that you type `/accept <request>` or `accept: <request>` in any chat.

| File | Language |
|---|---|
| [`prompts/universal-prompt.md`](../prompts/universal-prompt.md) | English |
| [`prompts/universal-prompt.tr.md`](../prompts/universal-prompt.tr.md) | Turkish |

Both versions follow the language you write in; pick the one you prefer to edit. The methods below are tied to your account, so once set up they work **on all your devices and in new chats**.

## ChatGPT

Copy the whole universal prompt and paste it into one of these:

1. **Custom GPT (most permanent, recommended):** create a GPT and paste the text into its **Instructions** field. Open that GPT on any device.
2. **Project:** create a Project and paste the text into the project instructions. It applies to every chat in that project.
3. **Custom Instructions:** in the personalization settings. Space can be limited; if it does not fit, use a Custom GPT or a Project.

Usage: `/accept merge the pdfs in a folder` or `accept: --ask delete old logs`.

> Menu names change over time; if you cannot find a field, look for "instructions" in the GPT/Project settings.

## Claude

- **Claude Code:** follow [INSTALL.md](INSTALL.md). `/accept` works as a command.
- **Claude.ai / Claude app (chat):** create a **Project** and paste the universal prompt into its project instructions. `/accept` then works in every chat in that project. For a one-off try, pasting the text once at the start of a chat is enough.

## Carrying your persistent context

- In Claude Code, the context lives in the skill's `context.md` (write it on each computer).
- In ChatGPT/Claude chat, the context is the lines you write in the **PERSISTENT CONTEXT** section at the bottom of the universal prompt. Fill it in once and it comes with you wherever you paste it.
- Never write passwords, API keys or tokens there.

## Summary by platform

| Where | Do once | Result |
|---|---|---|
| ChatGPT | Paste into a Custom GPT / Project / Custom Instructions | Works on all devices and in new chats |
| Claude.ai / app | Paste into Project instructions | Works in every chat of that project |
| Claude Code | Install on each computer with `install.ps1` / `install.sh` | Works in every session on that computer |
