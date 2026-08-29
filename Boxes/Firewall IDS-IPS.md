---
title: Untitled
type: note
permalink: oscp/boxes/untitled
---

## Which OS is the machine on?

### Command
```bash
sudo nmap -sS -Pn -sV -O $ip
```

##### Output
![[Pasted image 20260829143430.png]]
- Output reveals that Ubuntu was the OS

## Which DNS version are they using?

### Command
```bash
nmap -sU -p 53 -Pn $ip
```