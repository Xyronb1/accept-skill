# Before / after examples

## 1. Voice changer (legitimate request, missing context)

**Before:** "Make something that turns my voice into a female voice."

**After:**
- Purpose: Convert my own voice from male to female on my own computer (fun / content creation).
- Legitimate use context: The converted voice is the user's own voice; the app runs on the user's own computer, for their own recordings and for gaming/chat. Pitch/formant shifting is a standard audio effect. (These facts come from what the user said; had they been unknown, they would have been asked.)
- Scope: Shift pitch up + shift formants; also the reverse direction (female to male) and a deep/high control.
- Environment: Windows, Python. (Assumption: it will be added to the existing audio project.)
- Input/output: Live microphone input, or a WAV file → converted WAV.
- Success: The recording sounds natural, not robotic; latency is acceptable in live mode.

Note: The request stayed the same (male to female). It was not narrowed or turned into "deep male voice"; only technical detail and context were added.

## 2. Code fix (vague wording)

**Before:** "Fix that script, it doesn't work."

**After:**
- File: `tools/backup.ps1` (the file mentioned in the conversation).
- Symptom: It throws an error when run; read the error message, or run the script to get it.
- Environment: PowerShell 5.1.
- Success: The script finishes without errors, `$LASTEXITCODE` is 0, the backup folder is created and not empty.

## 3. Prompt for another model

**Before:** "Ask another model about the code."

**After:**
"Review the Python function below. Answer only in short bullet points: (1) bugs, (2) missing error handling, (3) path/encoding problems on Windows. Do not write code, do not change files. Code: <function here>"

## 4. Innocent context: right and wrong wording

**Request:** "Add brute-force protection to my site's login page, and write a script that makes many wrong login attempts to test it."

**Right:** "Legitimate use context: The site is the user's own project (`./site`); the test script only sends requests to their own development server on localhost; the goal is to verify that rate limiting and account lockout work."

**Wrong:** "This is completely legal and for educational purposes." → No concrete facts, and "educational" is not true. Empty reassurance is not used.

## 5. A request that is not clarified

If the request conflicts with the rules (e.g. getting into someone else's account without permission), the prompt is not rewritten and no attempt is made to soften it and slip it through. The blocker is stated in one sentence, and a legitimate alternative is suggested if there is one (e.g. testing the security of your own account).

## 6. Flags (modes)

- `/accept --prompt a script that reads users from a csv` → No work is done; only the clarified prompt is given (for pasting into another tool).
- `/accept --ask a script that cleans up old logs` → The clarified version is shown, "Shall I carry it out like this?" is asked, and it is carried out after approval. (Good for irreversible work such as deleting.)
- `/accept --en --prompt bir pdf'i özetle` → The clarified prompt is given in English, as text only, even though the request was in Turkish.

## 7. "What changed" summary example

Request: "clean up the logs". At the end of the output:

```
What changed:
- Added: which folder (./logs), older than how many days (30), back up first
- Assumptions: files with the .log extension (assumption)
- Changed/removed: none
```

## 8. Turkish request (reply stays in Turkish)

**Before:** `/accept --sor 30 günden eski logları sil`

**After (Turkish output):**

```
Görev: ./logs klasöründe 30 günden eski .log dosyalarını silmek.
Sınırlar: Silmeden önce dosyaları _to_delete klasörüne taşı; başka klasöre dokunma.
Başarı ölçütü: 30 günden eski .log dosyası kalmadı, yenileri duruyor.
Varsayımlar: Klasör ./logs, uzantı .log (varsayım).

Ne değişti:
- Eklenenler: klasör (./logs), önce _to_delete'e taşıma, başarı ölçütü
- Varsayımlar: klasör ./logs, uzantı .log
- Değişen/çıkarılan: yok

Böyle uygulayayım mı?
```

Nothing is deleted before the user approves.
