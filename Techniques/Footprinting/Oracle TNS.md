---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-3
---
## Overview
- The *Oracle Transport Network Substrate (TNS)* server is a communication protocol that is responsible for communication of oracle databases to applications over networks
- It supports *IPv6* and *SSL/TLS* which makes it good for Name resolution, connection management, load balancing, and security

---
## Default Configuration

- Listens for incoming connections on TCP port `1521`
- Also supports other protocols such as `TCP/IP`, `UDP`, `IPX/SPX`, and `AppleTalk`
- Only accepts connections from authorized hosts
- Config files are `tnsnames.ora` and `listener.ora`
	- Located in `$ORACLE_HOME/network/admin`
- has 