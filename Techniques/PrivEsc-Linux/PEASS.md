---
title: technique-note
type: note
permalink: oscp/templates/technique-note
---

---
title: PEASS
category: privesc
created: 2026-08-11
tags: [technique, privesc]
---

# Enumeration Scripts

## What it is
- Scripts such as *LinEnum*, *linuxprivchecker*, *Seatbelt*, and *JAWS* can check for privesc in linux
- *PEASS* is a well maintained script suite for linux privesc

## When to use it
- When you land as a low level user and want to escalate privileges

## Commands

#### Running a PEASS script called linpeas
```bash
./linpeas.sh

#output snippet
Linux Privesc Checklist: https://book.hacktricks.xyz/linux-unix/linux-privilege-escalation-checklist 
LEYEND: 
RED/YELLOW: 99% a PE vector 
RED: You must take a look at it 
LightCyan: Users with console 
Blue: Users without console & mounted devs 
Green: Common things (users, groups, SUID/SGID, mounts, .sh scripts, cronjobs) 
LightMangenta: Your username 
===========( Basic information )===========
OS: Linux version 3.9.0-73-generic 
User & Groups: uid=33(www-data) gid=33(www-data) groups=33(www-data)
```

## What to look for
### Kernel Exploits
- Potentially vulnerable if OS is old or not being maintained 
- For example, the `linpeas` output showed the linux version to be `3.9.0-73-generic` which results in a `CVE-2016-5195` using google or `searchsploit`. 
	- The linked vul is called `DirtyCow` which can be downloaded and run on the server to gain root access

### Vulnerable Software
- Look for installed software using `dpkg -l` in linux or `C:\Program Files` in windows to see what is installed
- Look for public exploits of any installed 

### User Privileges
- Look for the privileges we have access to  

## Boxes where I used this
- [[]]

## References
-