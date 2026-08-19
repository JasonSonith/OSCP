---
title: Box Template
type: template
permalink: oscp/templates/box-template
tags:
  - template
---

# Cap

## Steps I took

### Ran nmap scan:
![[Pasted image 20260819005710.png|640]]
- Ports 22, 21, and 80 open
	- 22: ssh
	- 21: ftp
	- 80: http server

### Ran Gobuster Scan:
![[Pasted image 20260819010013.png]]

- Went to `http://$ip/data/1`
	- Was able to do RBAC and get `/data/0` and download another user's pcap file

- Logged into `ftp` using `nathan:Buck3tH4TF0RM3!' 
	- password and username found in pcap files

- got the `user.txt` flag and used nathan's password to login to ssh

- Ran `linpeas.sh` script and found binary that can be used with sudo privileges: `/usr/bin/python3.8`

### Used python to escalate to user privileges
```python
import os
os.setuid(0)
os.system("/bin/bash")
```
- obtained `/root/root.txt` flag
## Techniques used
[[Nmap -sC and -sV (service + script scanning)]]

## What I learned
- OS command can be used to change users if python has root priveleges


## What I could do better

