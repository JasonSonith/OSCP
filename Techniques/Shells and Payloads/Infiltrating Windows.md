---
permalink: oscp/techniques/shells-and-payloads/infiltrating-windows
title: Infiltrating Windows
type: note
---

## Enumerating Windows & Fingerprinting Methods

### Pinging a Host
```bash
ping <IP>
```
- A ping with a `ttl` of either `32` or `128` most likely means it's a windows machine
- `-O` flag in `nmap` can also be used for what type of OS the target is running