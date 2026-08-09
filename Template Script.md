```
$vault = "C:\Users\sonit\vaults\OSCP"
$tpl   = Join-Path $vault "_templates"
New-Item -ItemType Directory -Force -Path $tpl | Out-Null

$boxNote = @'
<%*
// ── These prompts fire automatically when the note is created ──
box      = await tp.system.prompt("Box / target name");
ip       = await tp.system.prompt("Target IP");
os       = await tp.system.suggester(["Linux", "Windows"], ["Linux", "Windows"], false, "Target OS");
diff     = await tp.system.suggester(["Easy", "Medium", "Hard", "Insane"], ["Easy", "Medium", "Hard", "Insane"], false, "Difficulty");
platform = await tp.system.suggester(["HTB", "CPTS Lab", "Proving Grounds", "Other"], ["HTB", "CPTS Lab", "Proving Grounds", "Other"], false, "Platform");
await tp.file.rename(box);
-%>
---
title: <% box %>
ip: <% ip %>
os: <% os %>
difficulty: <% diff %>
platform: <% platform %>
status: in-progress
created: <% tp.date.now("YYYY-MM-DD") %>
tags: [box, <% platform.toLowerCase().replace(" ", "-") %>, <% os.toLowerCase() %>]
---

# <% box %> — <% ip %>

> **OS:** <% os %> · **Difficulty:** <% diff %> · **Platform:** <% platform %> · **Status:** #in-progress

---

## Recon
```bash
# nmap quick + full
nmap -sC -sV -oN nmap/initial <% ip %>
nmap -p- --min-rate 5000 -oN nmap/allports <% ip %>
```
- Open ports:
- Notable services / versions:

## Enumeration
- Web (dirb/gobuster/feroxbuster):
- SMB / shares:
- Other services:
- Creds / usernames found:

## Foothold / Initial Access
- Vulnerability:
- Exploit / steps:
```bash
# working commands
```
- **Technique:** [[]]

## Privilege Escalation

<%* if (os === "Windows") { -%>
### Windows checklist
- [ ] `whoami /priv` — token privs (SeImpersonate → Potato attacks)
- [ ] `systeminfo` — OS version / missing patches
- [ ] Weak/unquoted service perms (`accesschk`, WinPEAS, PowerUp)
- [ ] AlwaysInstallElevated
- [ ] Stored creds (`cmdkey /list`, registry, unattend.xml, SAM)
- [ ] Scheduled tasks
- [ ] Run **WinPEAS**
<%* } else { -%>
### Linux checklist
- [ ] `sudo -l` — sudo rights
- [ ] SUID/SGID (`find / -perm -4000 -type f 2>/dev/null`)
- [ ] Cron jobs / writable scripts
- [ ] Kernel version → known exploits
- [ ] Writable `/etc/passwd`, PATH hijack
- [ ] Capabilities (`getcap -r / 2>/dev/null`)
- [ ] Run **LinPEAS**
<%* } -%>

- Escalation path:
- **Technique:** [[]]

## Proof / Loot
- [ ] user.txt captured (screenshot w/ OSID)
- [ ] root/system proof captured (screenshot w/ OSID)
- Creds / hashes looted:
- Screenshots: `attachments/<% box %>/`

## Techniques used
- [[]]
- [[]]

## Lessons learned
- What slowed me down:
- What I'd do faster next time:
'@

$techNote = @'
<%*
tech = await tp.system.prompt("Technique name");
category = await tp.system.suggester(
  ["Recon", "Enumeration", "Initial Access", "Privilege Escalation", "Lateral Movement", "Persistence", "Exfiltration", "Other"],
  ["recon", "enumeration", "initial-access", "privesc", "lateral-movement", "persistence", "exfil", "other"],
  false, "Category");
await tp.file.rename(tech);
-%>
---
title: <% tech %>
category: <% category %>
created: <% tp.date.now("YYYY-MM-DD") %>
tags: [technique, <% category %>]
---

# <% tech %>

## What it is
_One or two lines in your own words — the ELI5, so future-you gets it fast._

## When to use it
- Signals / prerequisites that make this the right move:

## Commands
```bash
# paste your working, copy-pasteable commands
```

## Tools
- 

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
- 
'@

[System.IO.File]::WriteAllText((Join-Path $tpl "box-note.md"), $boxNote)
[System.IO.File]::WriteAllText((Join-Path $tpl "technique-note.md"), $techNote)

# keep basic-memory (and git) from touching the templates
Add-Content -Path (Join-Path $vault ".gitignore") -Value "`n_templates/"

Write-Host "Done. Files in $tpl :"
Get-ChildItem $tpl
```