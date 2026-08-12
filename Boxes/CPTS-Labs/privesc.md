---
title: box-note
type: note
permalink: oscp/templates/box-note-5
---

---
title: privesc
ip: 154.57.164.82
os: Linux
difficulty: Easy
platform: CPTS Lab
status: completed
created: 2026-08-12
tags: [box, cpts-lab, linux]
---

# privesc — 154.57.164.82

> **OS:** Linux · **Difficulty:** Easy · **Platform:** CPTS Lab · **Status:** #in-progress

---

## Recon
```bash
# nmap quick + full

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
- Screenshots: `attachments/privesc/`

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