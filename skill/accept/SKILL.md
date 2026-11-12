---
name: accept
description: Command-only. Runs only when the user types /accept; never load it on your own. Rewrites the given request (or, with no argument, the user's previous request) so it is clear and has its context spelled out, without changing its meaning, then carries it out. Works in any language (English and Turkish built in). It is not for bypassing filters, hiding a request, or dressing up a forbidden request so it gets through.
argument-hint: "[--prompt] [--ask|--sor] [--en|--tr] [request to clarify]"
disable-model-invocation: true
---

Request to clarify (after the flags are removed): $ARGUMENTS

If the line above is empty, or contains only flags, clarify the user's last request before this command.

# Prompt clarifier (/accept)

Goal: express **what the user wants** more clearly. Vague wording and missing context cause misunderstandings, extra rounds of questions and needless stalls. This skill rewrites the request with the same meaning, only clearer.

## Language

- Reply in the language the user wrote in. If the request mixes languages, use the language of the surrounding conversation.
- Write the clarified prompt in that same language, unless a language flag says otherwise (`--en` English, `--tr` Turkish).
- Translate the labels of the template, the "What changed" summary and the fixed phrases ("Here is how I understood it", "Shall I carry it out like this?", ...) into the reply language. Turkish versions are listed in `templates/clarified-prompt.md`.

## 0. Read the flags

Process the flags at the start of $ARGUMENTS and remove them from the text. Several can be combined (`--prompt --en`):

| Flag | Alias | Effect |
|---|---|---|
| `--prompt` | | Do not do the work yourself. The output is only the clarified prompt (Mode B), for pasting into another model or tool. |
| `--ask` | `--sor` (Turkish) | Show the clarified prompt first; carry it out only after the user approves. |
| `--en` | | Write the clarified prompt in English. |
| `--tr` | | Write the clarified prompt in Turkish. |

No flag: clarify and carry out (Mode A). Rules for combinations and edge cases:

- Flags are read only at the start. A flag-like token later in the text (`fix the script --ask`) is part of the request; if it looks like a misplaced flag, ask in one short line.
- `--prompt` together with `--ask`: `--prompt` wins (no work is done, so there is nothing to approve).
- `--en` together with `--tr`: the last one wins.
- An unknown `--xyz` is not silently ignored: say "there is no such mode" and continue without it.

## 1. Read the persistent context

Read `context.md` in the skill folder. Treat what it says (environment, versions, frequently used projects) as known context and do not ask the user for it again. If the file is missing or still contains only the `<...>` placeholders, skip this step. `context.md` is only for facts that are **always true**; if something in it does not fit the current request, the request wins.

## Fixed rules

1. **The meaning stays the same.** Goal, scope and the desired result do not change. Only the wording becomes clearer: context is added, ambiguity is removed, limits are written down. Assumptions only fill in details the user never stated; they never change anything the user did state.
2. **No hiding.** Covering up the real request, softening it so it looks like something else, or slipping it through with wordplay is forbidden. The clarified prompt must state the real request **more openly**, never less.
3. **A forbidden request is not clarified.** If the request itself cannot be done (it conflicts with the rules), the prompt is not rewritten. State the blocker in one sentence, suggest the closest legitimate alternative if there is one, and ask "Shall I continue like this?"
4. **Never drop a part silently.** If any part of the request was removed or changed, say so explicitly. Silently turning a "male to female voice" request into "deep male voice" breaks this rule; narrowing a legitimate request is not clarifying it.
5. **No making things up.** Do not invent unknown details (version, file, environment). If you can read it from the project, read it; if not, mark the assumption explicitly as an "assumption".
6. **For an innocent request, state the real context openly.** If the request is legitimate but easy to misread, add **concrete and true** facts to the clarified prompt that show why it is innocent: the real purpose, whose data/voice/account/file it is (e.g. their own voice, their own computer), where and how it will be used, and the limits of the scope. Rules:
   - The facts come only from what the user said, the conversation, the project or `context.md`. If the purpose is unclear, do not invent it; ask one short question or leave that line out.
   - Do not add justifications that are not true: write "for research", "for education", "I am authorized", "security test" only if that is really the case.
   - Do not use empty reassurance ("this is completely legal and harmless") instead of concrete facts.
   - Context is not a key: no explanation makes a forbidden request legitimate; in that case rule 3 applies.

## Flow

1. **Read the flags and the context:** section 0 (flags) and section 1 (`context.md`).
2. **Extract the real request:** what exactly does the user want, and what for? Write it in one sentence.
3. **Legitimacy check:** is the request legitimate? If not, go to rule 3 and the "When you stop" section, and stop. If it is, continue.
4. **Find the gaps:** go through the headings in `references/checklist.md`. Do not count something already in `context.md` as missing. Fill in only what is really missing; do not inflate a simple request.
5. **Fill the gaps, in this order:**
   - If it can be taken from the conversation, the project or `context.md`, take it from there.
   - If there is a reasonable default, use it and mark it as an "assumption".
   - If it really changes the result and cannot be guessed, ask one short question.
6. **Write the clarified prompt:** use the `templates/clarified-prompt.md` template. For an innocent request that is easy to misread, fill the "Legitimate use context" line according to rule 6. Apply the language rules above. Examples: `references/examples.md`.
7. **Produce the "What changed" summary:** see the section below.
8. **Finish according to the mode:**
   - **Mode A (no flag):** If there are no assumptions, carry it out directly, starting with one line: "Here is how I understood it: ...". If there are assumptions, state them in the summary first; if they would change the result significantly, ask first.
   - **`--ask`:** Show the clarified prompt and the summary, ask "Shall I carry it out like this?", and carry it out after approval.
   - **`--prompt`:** Do not do the work. Give the clarified prompt (and the summary), then stop. Never put passwords, API keys or tokens in it.
9. **Correction:** While the task started by this `/accept` is still being discussed, a correction applies without retyping `/accept`. If the user says "that is not what I meant", find the wrong assumption, update the prompt according to what they said, say which part of the work is affected, and redo that part.

## "What changed" summary

End every output with a short list so the user sees at a glance what was added (translate the labels into the reply language; Turkish: "Ne değişti", "Eklenenler", "Varsayımlar", "Değişen/çıkarılan", "yok"):

```
What changed:
- Added: <context/limits added to the request; delete if none>
- Assumptions: <guessed details; delete if none>
- Changed/removed: <difference from the original request; otherwise "none">
```

If the "Changed/removed" line is not "none", point it out separately.

## When you stop, say why

When you cannot clarify the request and stop (missing information, or rule 3), say in plain words **which piece of information is missing**, so the user knows what to add to continue. Example: "This looks like access to an account; if it is legitimate, tell me that the account is yours or whose it is, and I can clarify it."

This section is only for asking for **missing legitimate context**. Do not analyze the safety filter, and do not guess "which sentence got flagged / what to change so it passes"; that is not this skill's job.

## Keep it short

- This skill runs only when the user types /accept; do not activate it on your own at any other time.
- If the request is already clear, do not stretch it: say "Already clear, here is how I understood it: ..." and carry it out.
- If the user deliberately asks an open-ended question (ideas, brainstorming), do not force it into the template; only clarify the goal and the limits.

For forbidden requests the skill does no clarifying; only rule 3 applies.

## Output tone

In the user's language and short. The clarified prompt itself is plain and technical; no emoji in it.
