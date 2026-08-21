---
title: Box Template
type: template
permalink: oscp/templates/box-template
tags:
  - template
---

# get-started-knowledge-check

## Steps I took

### Ran nmap scan and found port 80 open
![[Pasted image 20260821160558.png]]

### Found getstarted.htb is the domain and added it to `/etc/hosts`
![[Pasted image 20260821160649.png]]

### Ran Gobuster scan and found a the following pages
![[Pasted image 20260821160757.png]]

- Reset password by navigating to admin page and found the hash 
### Admin hash found in `http://gettingstarted.htb/data/users/admin.xml`:
![[Pasted image 20260821160916.png]]
- used `hashid` to find out the hash was in sha1 then cracked it in hashcat to find the password was `admin`

### Found vulnerability in `searchsploit` for RCE:
![[Pasted image 20260821161100.png]]
- Use metasploit to search it up and use the vulnerability `multi/http/getsimplecms_unauth_code_exec`
- got a reverse shell and ran `linpeas` to find the `usr/bin/php` is executable by my user as sudo

### Used payload to escalate to root
```bash
sudo php -r 'system("/bin/sh -i");'
```
## Techniques used
[[Nmap -sC and -sV (service + script scanning)]]
[[Gobuster]]
[[PEASS]]
[[me]]


## What I learned


## What I could do better

