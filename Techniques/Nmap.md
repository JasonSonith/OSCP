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

### Packet Tracing
![[Pasted image 20260824095640.png]]
- `--packet-trace` shows all packets sent and received
- `-n` Disables DNS resolution
- `--disable-arp-ping`: Disables arp ping and shifts to other things for discovery such as `ICMP` and `TCP probe`

##### Output of request
- `10.10.14.2:63090 >` The IP address and source port used by NMAP to send packets
- `10.129.2.28:21` Shows target address and port
- `S`: Syn flag the was sent
- `ttl=56 id=57322 iplen=44 seq=1699105818 win=1024 mss 1460`: Other TCP header parameters
##### Output of Response
`RCVD (0.0573s)` Indicates the received packet from the target
`TCP`: Protocol being used 
`RA` RST and ACK flags of the sent TCP packet

### Scanning UDP
![[Pasted image 20260824103536.png]]
- `-F` scans top 100 ports 
- If `UDP` is open, we only get the response the application is configured to do so
	- We might now get a response back for some ports because `NMAP` sends a empty datagram protocol so we can't tell if the UDP packet has arrived at all
	- `--reason` can be used to determine why a port is in a specific state

### Error code 3
![[Pasted image 20260824104024.png]]
- An icmp response with `(type=3/code=3)` in the response means the port was unreachable
	- Other `IMCP` requests mark the response as `open|filtered`

### Creating HTML reports
![[Pasted image 20260824110753.png]]
- Use `-oX` flag for xml report on nmap then run `xsltproc {scan}.xml`

---
## Things to know
- `sS` flag sends the `SYN-ACK` flag in the TCP handshake so it scans really fast
	- If the target responds with a RST flag then the port is closed
	- If Nmap does not receive a response back then it is filtered
- `sT` does full TCP handshake and runs when nmap is not ran with sudo
	- Least stealthy because it established a full connections, creating more logs as a result
	- More accurate than `sS`

### Discovery
- *Open Ports:* Connection to the scanned port was established
- *Closed:* Can be used to see if the host is alive or not. Closed means the packet we sent gave us a `RST` flag back (The "Reset" flag that tells us to stop the connection right now)
- *Filtered:* Nmap can't identify if he port is opened or closed because there is no response or we get an error code 
	- Some firewalls are configured to drop or reject certain packets but nmap has default `--max-retries=10` so it's keep to keep trying because it thinks the last packet was malformed or mishandled
- *Unfiltered:* This happens during the `TCP-ACK` part of the scan and it means the port is accessible but we can't tell if it's opened or closed
- *open|filtered:* For if we do not get a response for a specific port because the firewall or packet filter protects the port
- *closed|filtered:* Impossible to determine if the scanned port is closed or filtered by the firewall

- `--top-ports=10`: Scans top 10 ports
- `-F` Does a fast port scan on 100 ports
- `-n` disables DNS resolution

### Open UDP Ports
- `-sU` flag used for UDP
- Sometimes `UDP` ports are not filtered in the environment we are attacking due to sysadmin misconfigurations
- We do not receive any acknowledge since UDP is connectionless and timeout is much longer 