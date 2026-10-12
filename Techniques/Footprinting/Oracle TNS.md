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
- Has 9 default passwords in `CHANGE_ON_INSTALL`
- Oracle DBSNMP service has `dbsnmp` as the default password

#### `tnsnames.ora`
```txt
ORCL =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 10.129.11.102)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )
```
- In database or service has a entry in this file which has information for clients to connect to this service
- Here a service called `ORCL` listening TCP port `1521` 