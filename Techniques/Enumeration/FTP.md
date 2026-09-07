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
	- If firewall protects the client, the server cannot rep