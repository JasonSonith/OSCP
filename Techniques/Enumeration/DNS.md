---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-5
---
## Overview
- Resolves domains to IP addresses
- How it works:
	1) Computer asks for DNS query
	2) DNS resolver checks its map recursively
	3) Root Name server points the way
	4) TLD Name server points it down
	5) Authoritative Name server delivers the address
	6) DNS resolver returns the Information 
	7) Computer connects

## Host files
- File that maps hostnames to IP addresses 
- On *Windows* it is in `C:\Windows\System32\drivers\etc\hosts`
- On *Linux* it is in `/etc/hosts`

#### Example host file
```txt
127.0.0.1       localhost
192.168.1.10    devserver.local
```