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