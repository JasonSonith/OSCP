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

### PL/SQL Exclusion List
- This is a blacklist placed in `$ORACLE_HOME/sqldeveloper` and is responsible for excluding PL/SQL packages from execution

|**Setting**|**Description**|
|---|---|
|`DESCRIPTION`|A descriptor that provides a name for the database and its connection type.|
|`ADDRESS`|The network address of the database, which includes the hostname and port number.|
|`PROTOCOL`|The network protocol used for communication with the server|
|`PORT`|The port number used for communication with the server|
|`CONNECT_DATA`|Specifies the attributes of the connection, such as the service name or SID, protocol, and database instance identifier.|
|`INSTANCE_NAME`|The name of the database instance the client wants to connect.|
|`SERVICE_NAME`|The name of the service that the client wants to connect to.|
|`SERVER`|The type of server used for the database connection, such as dedicated or shared.|
|`USER`|The username used to authenticate with the database server.|
|`PASSWORD`|The password used to authenticate with the database server.|
|`SECURITY`|The type of security for the connection.|
|`VALIDATE_CERT`|Whether to validate the certificate using SSL/TLS.|
|`SSL_VERSION`|The version of SSL/TLS to use for the connection.|
|`CONNECT_TIMEOUT`|The time limit in seconds for the client to establish a connection to the database.|
|`RECEIVE_TIMEOUT`|The time limit in seconds for the client to receive a response from the database.|
|`SEND_TIMEOUT`|The time limit in seconds for the client to send a request to the database.|
|`SQLNET.EXPIRE_TIME`|The time limit in seconds for the client to detect a connection has failed.|
|`TRACE_LEVEL`|The level of tracing for the database connection.|
|`TRACE_DIRECTORY`|The directory where the trace files are stored.|
|`TRACE_FILE_NAME`|The name of the trace file.|
|`LOG_FILE`|The file where the log information is stored.|

### Interacting