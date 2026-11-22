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
- A ping with a `ttl` of either `32` or `128` most likely means the target is a windows machine

### Banner Grabbing to Enumerate Ports
```bash
sudo nmap -v <IP> --script banner.nse
```
- Banner grabbing is used to find out what software or service is running on each open port

---

## Bats, DLLs, and MSI Files

- *DLLs (Dynamic Linking Library):* 