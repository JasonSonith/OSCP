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
- *Kerberos:* Network auth system that lets you authenticate without sending password over a network. This is how it works:
	1) Kerberos checks password and gives you a *Ticket Granting Ticket (TGT)*
	2) You get another TGT if you want to interact with something like a fileserver by using your current TGT to get the one for the file server
- `NFSv4` simplifies the use of the protocol across firewalls because it uses only UDP or TCP port 2049
- NFS is based on the *Open Network Computing Remote Procedure Call (ONC-RPC/SUN-RPC* protocol exposed on TCP and UDP port 111
- It uses RPC to communicate which lets your computer ask another computer to perform actions like opening a file or looking for the contents of a certain directory
- NFSv4 uses *XDR* to send data between different systems
- NFS provides a *UID* and a *GID* to a client which assigns permissions to them and those permissions are checked before performing any actions

## NFS Basic Flow
```
Your computer
    |
    | "I'm UID 1000, give me file.txt"
    v
RPC
    |
    v
NFS Server
    |
    | Check file owner/group/permissions
    v
file.txt
```
- This is important in pentesting because NFS misconfigurations can cause a attacker to manipulate their local UID to gain access to files they normally shouldn't have 

## Default Configuration 
- NFS is easier to configure than FTP or SMB because there aren't as many options
- `/el`