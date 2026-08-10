---
title: SNMP Enumeration (onesixtyone + snmpwalk)
type: technique
permalink: oscp/techniques/enumeration/snmp-enumeration-onesixtyone-snmpwalk
tags:
- enumeration
- snmp
- credentials
- udp
---

# SNMP Enumeration (onesixtyone + snmpwalk)

**Phase:** Enumeration / recon
**Default ports:** UDP 161 (queries), 162 (traps)
**When:** SNMP shows up in a scan, or you're enumerating a router/switch/printer/server for leaked info.

## What SNMP is (plain terms)
SNMP (Simple Network Management Protocol) is how network gear is monitored/managed remotely. You query the device over the network and it *tells you about itself* — hostname, OS, running processes, routing, interfaces, software versions. Great for admins, a goldmine for us.

## Community strings = the password
To query SNMP (v1/v2c) you need a **community string** — a shared password that unlocks info.
- `public` = default string for **reading** info
- `private` = default string for **read + write** (change settings)

These factory defaults are constantly left unchanged, so you often guess the "password" on the first try.

## Why v1 / v2c are weak
In SNMP **v1 and v2c** the community string is sent in **plaintext** — no encryption, no real auth. Know the string, you're in. Encryption + authentication were only added in **v3**. So v1/v2c are the soft targets.

## The workflow: find the string, then loot
Two tools used **in sequence**, not either/or.

### Step 1 — onesixtyone (the fast finder)
Sprays a wordlist of candidate community strings at the device and flags which one works. (Name = a nod to SNMP port 161.)
```
onesixtyone -c dict.txt 10.129.42.254
```
- `-c dict.txt` = **wordlist** of community strings to try (one per line). NOTE: here `-c` means "use this list," different from snmpwalk where `-c` is a single string.

Example hit:
```
Scanning 1 hosts, 51 communities
10.129.42.254 [public] Linux gs-svcscan 5.4.0-66-generic ... x86_64
```
→ tried 51 strings, `public` worked, device leaked OS + hostname immediately.

### Step 2 — snmpwalk (the deep digger)
Now that you know the valid string, pull everything.
```
snmpwalk -v 2c -c public 10.129.42.253
```
- `-v 2c` = SNMP version 2c
- `-c public` = the community string that worked
- no OID at the end = **walk from the top, dump all readable info** (the fishing expedition — where process args & possible creds surface)

Query one specific thing instead by appending an **OID**:
```
snmpwalk -v 2c -c public 10.129.42.253 1.3.6.1.2.1.1.5.0
iso.3.6.1.2.1.1.5.0 = STRING: "gs-svcscan"
```
That OID = the device hostname (sysName). `iso` printed on the left is just the label for the leading `1` of the tree.

## What an OID is
Object Identifier — SNMP organizes everything into a giant numbered tree; each dotted number is the address of one piece of info, like map coordinates. Give snmpwalk a **branch** (short OID) → it walks everything under it. Give it a **full leaf** (ends in `.0`) → one value.

Handy OIDs:
| OID | What it returns |
|---|---|
| `1.3.6.1.2.1.1.5.0` | hostname (sysName) |
| `1.3.6.1.2.1.1.1.0` | full system description (OS/kernel) |
| `1.3.6.1.2.1.25.4.2.1.2` | running process names |
| `1.3.6.1.2.1.25.4.2.1.5` | **process command-line args** ← creds sometimes leak here |

## The real payoff
- **Creds on the command line:** a process launched like `backup.sh --password Hunter2` exposes that password in its args — SNMP will list it.
- **Password reuse:** a password scraped here often works on SSH/FTP/web too → your actual foothold.
- **Network map:** routing, extra interfaces, software versions → what else is on the network + versions to check for known vulns.

**Mental model:** onesixtyone finds the password; snmpwalk uses it to loot. SNMP itself is boring — the *credential it leaks* is what opens a real door.

## Related
- [[ss - finding internal services]]
- [[Password Reuse]]
- [[_MOCs/Methodology]]
