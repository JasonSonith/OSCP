---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-6
---

## Overview 
- Remote management is part of Windows hardware that manage server hardware locally and remotely
- The main components are:
	- Remote Desktop Protocol `RDP`
	- Windows Remote Management `WinRM`
	- Windows Management Instrument `WMI`

---
# RDP

## Overview
- For remote access to other computers
- Typically uses `port 3389` on `TCP/IP` but can also use `UDP`
- The network firewall and firewall on server must allow connections from outside
- Port forwarding on the NAT router needs to be enabled in the direction of the server
- RDP supports *TLS/SSL*

## Foot printing the service

#### Nmap
```bash
Starting Nmap 7.92 ( https://nmap.org ) at 2021-11-06 15:45 CET
Nmap scan report for 10.129.201.248
Host is up (0.036s latency).

PORT     STATE SERVICE       VERSION
3389/tcp open  ms-wbt-server Microsoft Terminal Services
| rdp-enum-encryption: 
|   Security layer
|     CredSSP (NLA): SUCCESS
|     CredSSP with Early User Auth: SUCCESS
|_    RDSTLS: SUCCESS
| rdp-ntlm-info: 
|   Target_Name: ILF-SQL-01
|   NetBIOS_Domain_Name: ILF-SQL-01
|   NetBIOS_Computer_Name: ILF-SQL-01
|   DNS_Domain_Name: ILF-SQL-01
|   DNS_Computer_Name: ILF-SQL-01
|   Product_Version: 10.0.17763
|_  System_Time: 2021-11-06T13:46:00+00:00
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 8.26 seconds
```
- This can tell if `NLA` (network level authentication) is enabled
- 