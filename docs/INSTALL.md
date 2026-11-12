# Installing /accept in Claude Code

🌐 **English** · [Türkçe](INSTALL.tr.md)

`/accept` is a Claude Code skill. It clarifies your request without changing its meaning, adds the missing context and carries it out. It runs only when you type `/accept`; it never activates on its own.

## Option 1 — Install script (recommended)

Clone the repository first:

```bash
git clone https://github.com/Xyronb1/accept-skill.git
cd accept-skill
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

### macOS / Linux

```bash
bash scripts/install.sh
```

If an `accept` skill is already installed, it is **not deleted**: it is moved to `~/.claude/skills_backup/accept_<timestamp>`. The backup is kept outside the `skills` folder so Claude Code does not see two `/accept` commands.

### Install for one project only

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target C:\path\to\project\.claude\skills
```

```bash
bash scripts/install.sh /path/to/project/.claude/skills
```

## Option 2 — Manual copy

Copy the `skill/accept` folder as it is to:

| System | Personal (all projects) | One project |
|---|---|---|
| Windows | `%USERPROFILE%\.claude\skills\accept` | `<project>\.claude\skills\accept` |
| macOS / Linux | `~/.claude/skills/accept` | `<project>/.claude/skills/accept` |

`dist/accept-skill.zip` contains the same `accept` folder, ready to extract into the `skills` folder.

Restart Claude Code after installing.

## First setup: context.md

Open `context.md` in the installed skill folder and write down your details: operating system, shell, languages and versions, reply language, preferences that apply to every task, frequently used projects. The skill treats these as known and does not ask you again. Leave it empty and the skill simply skips this step. **Never write passwords, API keys or tokens in it.**

## Usage

| Command | What it does |
|---|---|
| `/accept <request>` | Clarifies the request and carries it out |
| `/accept` | Clarifies your previous request |
| `/accept --prompt <request>` | Only returns the clarified prompt (for another AI/tool) |
| `/accept --ask <request>` | Shows the clarified version first, carries it out after you approve (`--sor` in Turkish) |
| `/accept --en <request>` | Writes the clarified prompt in English |
| `/accept --tr <request>` | Writes the clarified prompt in Turkish |

Flags can be combined: `/accept --prompt --en <request>`. Every output ends with a short **"What changed"** summary.

## Verify the installation

```powershell
powershell -ExecutionPolicy Bypass -File .\tests\validate.ps1
powershell -ExecutionPolicy Bypass -File .\tests\validate.ps1 -SkillDir $HOME\.claude\skills\accept
```

On macOS / Linux the same script runs with PowerShell 7: `pwsh tests/validate.ps1`.

For behavior tests, try the requests in [`tests/test-scenarios.md`](../tests/test-scenarios.md) one by one.

## Uninstall

Delete the `accept` folder from your `skills` folder and restart Claude Code.
