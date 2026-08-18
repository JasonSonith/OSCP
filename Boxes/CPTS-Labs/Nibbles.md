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

## Techniques used


## What I learned


## What I could do better

