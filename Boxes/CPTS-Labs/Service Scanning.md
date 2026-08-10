---
title: box-note
type: note
permalink: oscp/templates/box-note-1
---

---
title: Service Scanning
ip: 10.129.104.219
os: Linux
difficulty: Easy
platform: CPTS Lab
status: in-progress
created: 2026-08-09
tags: [box, cpts-lab, linux]
---

# Service Scanning — 10.129.104.219

> **OS:** Linux · **Difficulty:** Easy · **Platform:** CPTS Lab · **Status:** #in-progress

---

## Recon
```bash
# nmap quick + full
nmap -sC -sV 10.129.104.219
``` 
- Open ports: `ftp`:21, `ssh`:22, `80`:http, `139`:netbios-ssn, `445`:netbios-ssn, `2323`:telnet, `8080`:http
- Services and Versions: `ftp:vsftpd 3.0.3`, `ssh:OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol`, `http(80):Apache httpd 2.4.41 ((Ubuntu))`, `http(8080): Apache Tomcat`, `netbios-ssn(139 & 445):Samba smbd 4`, `telnet: Linux telnetd`

## Enumeration
- SMB / shares:
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
- Screenshots: `attachments/Service Scanning/`

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