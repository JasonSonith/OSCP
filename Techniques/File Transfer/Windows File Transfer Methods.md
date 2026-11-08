---
permalink: oscp/techniques/file-transfer/untitled-1
title: Untitled
type: note
---
## Fileless Malware
- Attacker tricks computer into executing malicious powershell command
- Powershell downloads malicious code from an attacker-controlled server
- Code executes in RAM without being saved as exe

---
## Powershell Base64 Encode and Decode
- If you have access to the target machine, copying the payload from your box to the target is easiest
- *md5sum* can be used to calculate if the payloads match between target and host

#### Check SSH Key MD5 Hash
```bash
SonithGT@htb[/htb]$ md5sum id_rsa

4e301756a07ded0a2dd6953abf015278  id_rsa
```

#### Encode SSH Key to Base64
```bash
cat id_rsa |base64 -w 0;echo
```
#### Decoding back to to original in Powershell
```powershell
[IO.File]::WriteAllBytes("<DESTINATION PATH>", [Convert]::FromBase64String("<BASE64 STRING>"))
```

#### Confirm hashes match after decoding in Powershell
```Powershell
PS C:\htb> Get-FileHash C:\Users\Public\id_rsa -Algorithm md5
```

---
## Powershell Web Downloads

- Powershell can execute and download files from internet using *HTTP, HTTPS, AND FTP*
- Most companies allow HTTP/HTTPs traffic so this is a vulnerability

```bash

```