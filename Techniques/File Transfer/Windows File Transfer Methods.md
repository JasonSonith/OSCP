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
