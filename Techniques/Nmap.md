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
10.129.2.20 
10.129.2.28
```
- `-sn` flag disables port scanning
- `| grep for | cut -d" " -f5` only shows IPs within the subnet that are active
- This scan only works if the firewall allows it

### Scan Multiple IPs at a time
```bash
sudo nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20
```

##### Output
```
10.129.2.18 
10.129.2.19 
10.129.2.20
```
- You can also scan for `10.129.2-18-20` instead of typing in all three IP addresses at the same time

### Tracing the IPs
```bash
sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace
```

##### Output
![[Pasted image 20260822021122.png]]
- `-sn` disable ICMP requests
- `-PE --packet-trace` can show what type of requests are sending, in this case it is `ARP`

### using `-PE --reason` to check why a host is alive
![[Pasted image 20260822021352.png]]
- In this case, it is alive because ARP requests where sent successfully
- the attacker ip, `10.10.14.2`, asked who has `10.129.2.18`, RCVD said that `10.129.2.18` is up

### Use `-PE --packet-trace --disable-arp-ping` to disable ARP
![[Pasted image 20260822021624.png]]
