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
- used `hashid` to find
## Techniques used

- uses [[Technique name]]


## What I learned


## What I could do better

