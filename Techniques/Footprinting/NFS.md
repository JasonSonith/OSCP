---
title: NFS
type: note
permalink: oscp/techniques/footprinting/nfs
---

## What it is
- A network file system developed by sun microsystems and has the same purpose as *SMB*
- Used between Linux and Unix systems
	- Cannot communicate directly with SMB servers

## NFS Versions
|**Version**|**Features**|
|---|---|
|`NFSv2`|It is older but is supported by many systems and was initially operated entirely over UDP.|
|`NFSv3`|It has more features, including variable file size and better error reporting, but is not fully compatible with NFSv2 clients.|
|`NFSv4`|It includes Kerberos, works through firewalls and on the Internet, no longer requires portmappers, supports ACLs, applies state-based operations, and provides performance improvements and high security. It is also the first version to have a stateful protocol.|
- *Kerberos:* Network auth system that 