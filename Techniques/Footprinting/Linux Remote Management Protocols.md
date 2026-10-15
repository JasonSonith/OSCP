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

--- 
## Default Configuration

```bash
SonithGT@htb[/htb]$ cat /etc/ssh/sshd_config  | grep -v "#" | sed -r '/^\s*$/d'

Include /etc/ssh/sshd_config.d/*.conf
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
```
- `X11Forwarding yes` is a command injection vulnerability that is enabled by default
---
## Dangerous Settings

|**Setting**|**Description**|
|---|---|
|`PasswordAuthentication yes`|Allows password-based authentication.|
|`PermitEmptyPasswords yes`|Allows the use of empty passwords.|
|`PermitRootLogin yes`|Allows to log in as the root user.|
|`Protocol 1`|Uses an outdated version of encryption.|
|`X11Forwarding yes`|Allows X11 forwarding for GUI applications.|
|`AllowTcpForwarding yes`|Allows forwarding of TCP ports.|
|`PermitTunnel`|Allows tunneling.|
|`DebianBanner yes`|Displays a specific banner when logging in.|-

---

## Footprinting the Service