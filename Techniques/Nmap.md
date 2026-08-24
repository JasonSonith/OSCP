---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1-1-2
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
- This sends only our ICMP requests to check if a host is alive

## Things to know
- `sS` flag sends the `SYN-ACK` flag in the TCP handshake so it scans really fast
	- If the target responds with a RST flag then the port is closed
	- If Nmap does not receive a response back then it is filtered

- *Open Ports:* Connection to the scanned port was established
- *Closed:* Can be used to see if the host is alive or not. Closed means the packet we sent gave us a `RST` flag back (The "Reset" flag that tells us to stop the connection right now)
- *Filtered:* Nmap can't identify if he port is opened or closed because there is no response or we get an error code 
- *Unfiltered:* This happens during the `TCP-ACK` part of the scan and it means the port is accessible but we can't tell if it's opened or closed
- *open|filtered:* For if we do not g