---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-2
---

## FTP basics
- FTP is a server that allows for file transfer over a network
- Client sends commands to the server and server returns status codes

### Active vs Passive FTP
- In active, the client establishes a connection via TCP port 21 and informs the server which client port it can transmit it's responses over
	- If firewall protects the client, the server cannot reply
- Passive mode developed to counteract firewall, server announces a port through which the client can establish the data channel

## TFTP - Trivial File Transfer Protocol
- Simpler than FTP
- Does not provide user auth 
- TFTP uses UDP

#### Commands
|**Commands**|**Description**|
|---|---|
|`connect`|Sets the remote host, and optionally the port, for file transfers.|
|`get`|Transfers a file or set of files from the remote host to the local host.|
|`put`|Transfers a file or set of files from the local host onto the remote host.|
|`quit`|Exits tftp.|
|`status`|Shows the current status of tftp, including the current transfer mode (ascii or binary), connection status, time-out value, and so on.|
|`verbose`|Turns verbose mode, which displays additional information during file transfer, on or off.|
## Default Configuration
- Most used FTP server on linux is *vsFTPd*
	- Config file from in `/etc/vsftpd.conf`

#### Config File
