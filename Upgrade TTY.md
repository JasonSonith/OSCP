---
title: technique-note
type: note
permalink: oscp/templates/technique-note
---

---
title: Upgrade TTY
category: other
created: 2026-08-11
tags: [technique, other]
---

# Upgrade TTY

## What it is
- Making the shell an actual shell because after binding to a shell we can type commands or backspace

## When to use it
- Whenever you get a shell session

## Commands

#### Upgrade TTY
```bash
python -c 'import pty; pty.spawn("/bin/bash")'
```
- After running this, hit `Ctrl + Z` to background the shell and go back to the our local terminal
#### After backgrounding TTY
```bash
#first
stty raw -echo
#second
fg
```
- hit `enter` after to get back to our shell

#### Open a new terminal window
```bash
echo $TERM
```

```bash
xterm-256color
```

```bash
stty size
```

#### Go back to `netcat` shell
```bash
export TERM=xterm-256color
```

```bash
stty rows 67 columns 318
```

## Tools
- 

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
-