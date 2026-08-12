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
- The following can exploit privesc
	1) `Sudo`
	2) `SUID`
	3) `Windows Token Privileges`
- we can check what `sudo` privileges we have through `sudo -l` command
	- An Output of `(ALL : ALL) ALL` means we have complete access and we can `sudo su -` to switch to root user
	- An output of `(user : user) NOPASSWD: /bin/echo` means `/bin/echo` can we executed without a password
- [GTFOBins](https://gtfobins.org/) can be used for exploiting privesc through `sudo`
- [LOLBAS](https://lolbas-project.github.io/#) can be used for the same thing through windows

### Scheduled Tasks
- Two ways to take advantage of scheduled tasks or cron jobs for linux
	1) Add new scheduled tasks/crons
	2) Trick them to execute malicious software
- In linux, specific directories can add cron jobs if we have write permissions such as
	1) `/etc/crontab`
	2) `/etc/cron.d`
	3) `/var/spool/cron/crontabs/root`
	- If we can write to the above directories then we can write a bash script with *reverse shell* commands

### Exposed Credentials
- Look for files we can read and see if they have exposed creds through config files, log files, and user history files (`bash_history` in linux and `PSReadLine` in Windows)
- Enumeration scripts above usually look for these files

 #### Example of Enumeration script showing passwords inside logs
 ``` bash
 [+] Searching passwords in config PHP files 
 [+] Finding passwords inside logs (limit 70)
 /var/www/html/config.php: $conn = new mysqli(localhost, 'db_user', 'password123');
 ```
- here database creds are exposed which can be used to log int
## Boxes where I used this
- [[]]

## References
-