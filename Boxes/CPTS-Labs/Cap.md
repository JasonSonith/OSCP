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


## Techniques used
[[Nmap -sC and -sV (service + script scanning)]]



## What I learned


## What I could do better

