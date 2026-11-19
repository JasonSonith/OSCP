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

#### Attacker connects to target
```bash
nc -nv <TARGET IP> <PORT>
```

