---
title: technique-note
type: note
permalink: oscp/templates/technique-note-1
---

---
title: Gobuster
category: enumeration
created: 2026-08-10
tags: [technique, enumeration]
---

# Gobuster

## What it is
- **Gobuster** is used for directory enumeration using a *wordlist* to find *hidden directories* and files using the `dir` flag.
- **Gobuster** can also be used for *vhost* which enumerates through a list of domains until it matches a given *IP*.
- **Gobuster** also DNS capabilities which goes to the DNS server and finds domains that that match to a given wordlist
	- *Example*: Wordlist has `dev` so DNS mode attaches the domain you gave, `example.com`, -> `dev.example.com` and asks if it resolves to an IP

## When to use it
- When trying to find hidden directories, finding a domain to match an IP, or finding other domains are attach to your given domain

## Commands

#### Directory Enumeration Command
```bash
gobuster dir -u http://10.10.10.121/ -w /usr/share/seclists/Discovery/Web-Content/common.txt
```
- This enumerates through a website to find hidden domains with the provided `common.txt` wordlist

#### DNS Enumeration Command
```
gobuster dns -d inlanefreight.com -w /usr/share/SecLists/Discovery/DNS/namelist.txt
```
- This enumerates through a list of domains that will resolve to an IP given the wordlist `namelist.txt` from the `Seclists` wordlist

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
----
title: Untitled
type: note
permalink: oscp/techniques/enumeration/web/untitled
---