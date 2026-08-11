---
title: box-note
type: note
permalink: oscp/templates/box-note-3
---

---
title: web-enumeration
ip: 154.57.164.65
os: Linux
difficulty: Easy
platform: CPTS Lab
status: completed
created: 2026-08-10
tags: [box, cpts-lab, linux]
---

# web-enumeration — 154.57.164.65

> **OS:** Linux · **Difficulty:** Easy · **Platform:** CPTS Lab · **Status:** #completed

---

## Recon
```bash
# nmap quick + full
nmap -sC -sV -oN nmap/scan.txt 154.57.164.65
```
- Open ports: `30718`
- Notable services / versions: *http*: Werkzeug httpd 3.0.4 (Python 3.11.2)

## Enumeration
- Web (dirb/gobuster/feroxbuster): Found `200 OK` for `index.php` and `robots.txt`. Found 
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

### Linux checklist
- [ ] `sudo -l` — sudo rights
- [ ] SUID/SGID (`find / -perm -4000 -type f 2>/dev/null`)
- [ ] Cron jobs / writable scripts
- [ ] Kernel version → known exploits
- [ ] Writable `/etc/passwd`, PATH hijack
- [ ] Capabilities (`getcap -r / 2>/dev/null`)
- [ ] Run **LinPEAS**

- Escalation path:
- **Technique:** [[]]

## Proof / Loot
- [ ] user.txt captured (screenshot w/ OSID)
- [ ] root/system proof captured (screenshot w/ OSID)
- Creds / hashes looted:
- Screenshots: `attachments/web-enumeration/`

## Techniques used
- [[]]
- [[]]

## Lessons learned
- What slowed me down:
- What I'd do faster next time:---
title: Untitled
type: note
permalink: oscp/boxes/cpts-labs/untitled
---