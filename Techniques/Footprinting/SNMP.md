---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled
---
## Overview
- *SNMP* (Simple Network Management Protocol) was created to monitor network devices
- SNMP enabled hardware devices are routers, switches, servers, IOT devices, and other devices that share that protocol
- Transmits control commands on port `161`
- SNMP traps are served on `162` which means clients received packets without requesting (maybe something triggers it server-side)

---
## MIB
- *MIB* (Management Information Base) was created to ensure SNMP access works across manufacturers with different client side combinations
- MIB is a text file that provides information of a object such as *OID* (Object Identifier), access rights, description, etc. of a specific object

---
## OID
- *OID* is the address of a specific piece of information that SNMP can read such as device name or uptime

#### It is in tree format
```
1.3.6.1.2.1.1.5.0
              │ │
              │ └─ This particular value (instance)
              └─── Device name (sysName)
```
- Each number takes you further down a tree 

---
## SNMP versions
- There are three versions *SNMPv1*, *SNMPv2*, and *SNMPv3* 
- v1 uses a shared community string (shared password included with requests) and sends data without encryption
- v2 has same weakness as v1 except it improves information retrieval
- v3 supports user accounts, verifies authenticity, and provides encryption

---
## Default Configurations
- Default configuration provides basic settings such as IP addresses, p