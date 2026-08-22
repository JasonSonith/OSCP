---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1-1
tags:
  - template
---

# Nmap

## What it is
- Enumeration tool
- Always to get a idea of what you are attacking

## When to use
- Attacking anything with an IP

## How to test

## Things to know
- `sS` flag sends the `SYN-ACK` flag in the TCP handshake so it scans really fast
	- If the target responds with a RST flag then the port is closed
	- If Nmap does not receive a response back then it is filtered
### Scanning a network range
```bash
sudo nmap 10.129.2.0/24 -sn -oA tnet | grep for | cut -d" " -f5
```

##### Output
```
10.129.2.4 
10.129.2.10 
10.129.2.11 
10.129.2.18 
10.129.2.19 
10.129.2.20 1
0.129.2.28
```
- `-sn` flag disables port scanning
- 