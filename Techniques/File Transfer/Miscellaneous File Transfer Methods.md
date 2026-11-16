---
permalink: oscp/techniques/file-transfer/untitled-2
title: Untitled
type: note
---

## Netcat

#### NetCat - Compromised machine listening on Port 8000
```bash
nc -l -p 8000 > <FILE TO SAVE DATA TO>
```
- `Netcat` takes whatever data it receives and writes it to the specified file

#### Ncat - Compromised machine listening on port 8000
```bash
ncat -l -p 8000 --recv-only > <FILE TO SAVE DATA TO>
```

#### NetCat 