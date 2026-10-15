---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-5
---
## SSH
- There are two different protocols `SSH-1` and `SSH-2`
- `SSH-2` is more advanced 
- `SSH-1` is prone to `MITM` attacks
- SSH has *six different authentication methods:*
	1) Password authentication
	2) Public-key authentication
	3) Host-based authentication
	4) Keyboard authentication
	5) Challenge-response authentication
	6) GSSAPI authentication

### Public Key Authentication
- The computer checks the SSH's server's identity by copying the fingerprint of the public and storing it if anything changes
- Authentication happens through a password or if the public key is placed onto the server as a allowed key
- Passphrase protects private key through the SSH Agent which can keep the unlocked key available so the passphrase doesn't have to be entered every connection