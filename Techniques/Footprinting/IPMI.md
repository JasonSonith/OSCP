---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-4
---

## Overview
- *Intelligence Platform Management Interface* (IPMI) is a set of standardized specifications for hardware based host management systems 
- IPMI is used in three ways:
	1) Before the OS has booted to modify BIOS settings
	2) When the host is fully powered down
	3) Access to a host after system failure

---
## Foot printing the service

#### NMAP
```bash
SonithGT@htb[/htb]$ sudo nmap -sU --script ipmi-version -p 623 ilo.inlanfreight.local

Starting Nmap 7.92 ( https://nmap.org ) at 2021-11-04 21:48 GMT
Nmap scan report for ilo.inlanfreight.local (172.16.2.2)
Host is up (0.00064s latency).

PORT    STATE SERVICE
623/udp open  asf-rmcp
| ipmi-version:
|   Version:
|     IPMI-2.0
|   UserAuth:
|   PassAuth: auth_user, non_null_user
|_  Level: 2.0
MAC Address: 14:03:DC:674:18:6A (Hewlett Packard Enterprise)

Nmap done: 1 IP address (1 host up) scanned in 0.46 seconds
```
- IPMI listens on port `623`
- Systems that use IPMI are called *Baseboard Management Controllers (BMCs)*
#### Metasploit
![[Pasted image 20261013174515.png]]

#### Default Passwords in BMCs

|Product|Username|Password|
|---|---|---|
|Dell iDRAC|root|calvin|
|HP iLO|Administrator|randomized 8-character string consisting of numbers and uppercase letters|
|Supermicro IPMI|ADMIN|ADMIN|

---
## Dangerous Settings
- If default creds don't work then the RAKP protocol can be leveraged in IPMI 2.0
	- This protocol has the server send a salted *SHA1* or *MD5* hash of the user's password to the client before authentication takes place
	- Can be cracked using *Hashcat mode 7300*: `hashcat -m 7300 ipmi.txt -a 3 ?1?1?1?1?1?1?1?1 -1 ?d?u`

#### Metasploit Dumping Hashes
![[Pasted image 20261013174910.png]]
- Here we found `ADMIN:8e160d4802040000205ee9253b6b8dac3052c837e23faa631260719fce740d45c3139a7dd4317b9ea123456789abcdefa123456789abcdef140541444d494e:a3e82878a09daa8ae3e6c22f9080f8337fe0ed7e`