---
title: technique-note
type: note
permalink: oscp/templates/technique-note
---

---
title: Searchsploit
category: enumeration
created: 2026-08-11
tags: [technique, enumeration]
---

# Searchsploit

## What it is
- Use to search for public vulnerabilities for any application

## When to use it
- For finding vulnerabilities of certain application/service versions after running nmap with `-sV` flag and getting the version

## Commands
```bash
searchsploit openssh 7.2

#output
OpenSSH 2.3 < 7.7 - Username Enumeration 
| linux/remote/45233.py OpenSSH 2.3 < 7.7 - Username Enumeration (PoC) 
| linux/remote/45210.py OpenSSH 7.2 - Denial of Service 
| linux/dos/40888.py OpenSSH 7.2p1 - (Authenticated) xauth Command Injection 
| multiple/remote/39569.py OpenSSH 7.2p2 - Username Enumeration 
| linux/remote/40136.py OpenSSH < 7.4 - 'UsePrivilegeSeparation Disabled' Forwarded Unix Domain Sockets Privilege Escalation 
| linux/local/40962.txt OpenSSH < 7.4 - agent Protocol Arbitrary Library Loading 
| linux/remote/40963.txt OpenSSH < 7.7 - User Enumeration (2) 
| linux/remote/45939.py OpenSSHd 7.2p2 - Username Enumeration 
| linux/remote/40113.txt
```

##### Table format of `searchsploit` output
| Title                                                    | Path                     |
| -------------------------------------------------------- | ------------------------ |
| OpenSSH 2.3 < 7.7 - Username Enumeration                 | linux/remote/45233.py    |
| OpenSSH 2.3 < 7.7 - Username Enumeration (PoC)           | linux/remote/45210.py    |
| OpenSSH 7.2 - Denial of Service                          | linux/dos/40888.py       |
| OpenSSH 7.2p1 - (Authenticated) xauth Command Injection  | multiple/remote/39569.py |
| OpenSSH 7.2p2 - Username Enumeration                     | linux/remote/40136.py    |
| OpenSSH < 7.4 - UsePrivilegeSeparation... Priv Esc       | linux/local/40962.txt    |
| OpenSSH < 7.4 - agent Protocol Arbitrary Library Loading | linux/remote/40963.txt   |
| OpenSSH < 7.7 - User Enumeration (2)                     | linux/remote/45939.py    |
| OpenSSHd 7.2p2 - Username Enumeration                    | linux/remote/40113.txt   |

- The following title, `OpenSSH 2.3 < 7.7 - Username Enumeration` means every version from 2.3 to 7.7 is affected by Username enumeration
- *Path* follows the syntax `{platform}/{type}/{id.extension}`
- **Platform:** can be `linux` or `multiple`, `multiple` meaning not one specific OS
- **Type:** Can either be `remote`, `local`, or `dos`. 
	- `remote`: Runs over network
	- `local`: Runs locally
	- `dos`: Crashes the service
- **id.extension**: the searchsploit's database ID number and file type
	- Full path for exploits is `/usr/share/exploitdb/exploits/{platform}/{type}/{id.ext}`

## Boxes where I used this
- [[]]

## References
- [[_MOCs/Methodology]]