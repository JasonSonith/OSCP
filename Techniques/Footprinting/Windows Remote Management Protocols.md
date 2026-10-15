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


- For remote access to other computers
- Typically uses `port 3389` on `TCP/IP` but can also use `UDP`
- The network firewall and firewall on server must allow connections from outside
- Port forwarding on the NAT router needs to be enabled in the direction of the server
- RDP supports *TLS/SSL*

####