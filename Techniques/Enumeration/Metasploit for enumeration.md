---
title: technique-note
type: note
permalink: oscp/templates/technique-note
---

---
title: Metasploit for enumeration
category: other
created: 2026-08-11
tags: [technique, other]
---

# Metasploit

## What it is
- Can be used for reconnaissance scripts to enumerate hosts and/or targets
- scripts to check for a vulnerability exists
- *Meterpreter* for connecting to shells on running commands on a compromised target
- Post-exploitation

## When to use it
- Signals / prerequisites that make this the right move:
	- Enumerating a host and finding a `exploit/` module that exists for a finding
	- Manual exploitation is too much work especially if you need encoding or setting up listeners
	- You want post exploitation things for pivoting, screenshotting, download files, etc after you have a foothold
	- You find valid creds and want to use a module that logs in and executes them (using `psexec`)

## Commands
#### Search for an exploit
```bash
search exploit {exploit}
```
- Gives description of the exploit and the exploit path related to it such as `exploit/windows/smb/ms17_010_psexec`
#### Use an exploit
```bash
use exploit/windows/smb/ms17_010_psexec
```

#### Show options of exploit after using it
```bash
show options
```

#### Set IPs of target
```
set RHOST {IP}
```

#### Set IP of where we are attacking from
```
set LHOST {IP}
```
- Can also be a network interface such as `tun0`, our HTB vpn IP
## Tools
- 

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
-