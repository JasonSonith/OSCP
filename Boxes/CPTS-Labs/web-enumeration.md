---
title: box-note
type: note
permalink: oscp/templates/box-note-2
---

---
title: web-enumeration
created: 2026-08-10
tags: [technique, enumeration]
---

# Gobuster

## What it is
- **Gobuster** is used for directory enumeration using a *wordlist* to find *hidden directories* and files using the `dir` flag.
- **Gobuster** can also be used for *vhost* which enumerates through a list of domains until it matches a given *IP*.
- **Gobuster** also DNS capabilities which goes to the DNS server and finds domains that that match to a given wordlist
	- *Example*: Wordlist has `dev` so DNS mode attaches the domain you gave, `example.com`, -> `dev.example.com` and asks if it resolves to an IP

## When to use it
- When trying to find hidden directories, finding a domain to match an IP, or finding other domains are attach to your given domain

## Commands

#### Directory Enumeration Command
```bash
gobuster dir -u http://10.10.10.121/ -w /usr/share/seclists/Discovery/Web-Content/common.txt
```
- This enumerates through a website to find hidden domains with the provided `common.txt` wordlist

#### DNS Enumeration Command
``` bash
gobuster dns -d inlanefreight.com -w /usr/share/SecLists/Discovery/DNS/namelist.txt
```
- This enumerates through a list of domains that will resolve to an IP given the wordlist `namelist.txt` from the `Seclists` wordlist
#### Server Header Grabbing
``` bash
curl -IL https://www.inlanefreight.com

#Output 
HTTP/1.1 200 OK 
Date: Fri, 18 Dec 2020 22:24:05 GMT 
Server: Apache/2.4.29 (Ubuntu) 
Link: <https://www.inlanefreight.com/index.php/wp-json/>; rel="https://api.w.org/" 
Link: <https://www.inlanefreight.com/>; rel=shortlink Content-Type: text/html; charset=UTF-8
```
- `-IL` flag uses `-I` to captures only headers and `L` to also follow redirects

#### Find tech stack using **Whataweb**
``` bash
---
title: web-enumeration
ip: 154.57.164.65
os: Linux
difficulty: Easy
platform: CPTS Lab
status: in-progress
created: 2026-08-10
tags: [box, cpts-lab, linux]
---

# web-enumeration — 154.57.164.65

> **OS:** Linux · **Difficulty:** Easy · **Platform:** CPTS Lab · **Status:** #in-progress

---

## Recon
```bash
# nmap quick + full
nmap -sC -sV -oN nmap/initial 154.57.164.65
nmap -p- --min-rate 5000 -oN nmap/allports 154.57.164.65
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
- Screenshots: `attachments/web-enumeration/`

## Techniques used
- [[]]
- [[]]

## Lessons learned
- What slowed me down:
- What I'd do faster next time:
whatweb 10.10.10.121

#Output
http://10.10.10.121 [200 OK] Apache[2.4.41], Country[RESERVED][ZZ], Email[license@php.net], HTTPServer[Ubuntu Linux][Apache/2.4.41 (Ubuntu)], IP[10.10.10.121], Title[PHP 7.4.3 - phpinfo()]
```
## Boxes where I used this
- [[]]

## References
----
title: Gobuster
type: note
permalink: oscp/techniques/enumeration/web/Gobuster
---