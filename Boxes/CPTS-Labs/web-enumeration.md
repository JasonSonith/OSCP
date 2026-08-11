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
- Web (dirb/gobuster/feroxbuster): 
	- Found `200 OK` for `index.php` and `robots.txt`. 
	- Found `301 REDIRECT` for `wordpress` endpoint
	- Found `admin-login-page.php` in robots.txt
- Creds / usernames found: 
	- Found `Username:Password` in *html* document using `Ctrl+U` and found admin:password123

## Foothold / Initial Access
- Vulnerability: 
- Exploit / steps:
#### Enumerate through directories
```bash
gobuster dir -u http://154.57.164.65:30728 -w /usr/share/seclists/Discovery/Web-Content/common.txt
```
- **Technique:** [[Gobuster]]

## Proof/Loot
- Screenshots: `attachments/web-enumeration/`
![[Pasted image 20260810233730.png]]


title: web-enumeration
type: note
permalink: oscp/boxes/cpts-labs/untitled
---
