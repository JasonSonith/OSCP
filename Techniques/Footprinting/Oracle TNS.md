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
- Here a service called `ORCL` listening TCP port `1521` on the IP `10.129.11.102` is present

#### `Listener.ora`

```txt
SID_LIST_LISTENER =
  (SID_LIST =
    (SID_DESC =
      (SID_NAME = PDB1)
      (ORACLE_HOME = C:\oracle\product\19.0.0\dbhome_1)
      (GLOBAL_DBNAME = PDB1)
      (SID_DIRECTORY_LIST =
        (SID_DIRECTORY =
          (DIRECTORY_TYPE = TNS_ADMIN)
          (DIRECTORY = C:\oracle\product\19.0.0\dbhome_1\network\admin)
        )
      )
    )
  )

LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = orcl.inlanefreight.htb)(PORT = 1521))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
  )

ADR_BASE_LISTENER = C:\oracle
```
- This file is responsible for receiving incoming client requests and forwarding them to the oracle database instance
- 