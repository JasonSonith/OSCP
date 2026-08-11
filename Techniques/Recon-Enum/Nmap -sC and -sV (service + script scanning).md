---
title: Nmap -sC and -sV (service + script scanning)
type: technique
permalink: oscp/techniques/enumeration/nmap-s-c-and-s-v-service-script-scanning
tags:
- enumeration
- nmap
- scanning
- nse
---

# Nmap -sC and -sV (service + script scanning)

**Phase:** Enumeration / recon
**When:** First-pass scan of any target once you know a port is open. Standard opener.

## The two flags, plain terms
- **`-sV` = "what version is running?"** Probes each open port and identifies the service *and* version. Bare nmap says "port open"; `-sV` says "OpenSSH 8.2p1 on Ubuntu." Difference between knowing a door exists and reading the brand off the lock.
- **`-sC` = "run the default scripts against it."** The `C` = scripts. Runs nmap's **default** set of NSE scripts (Nmap Scripting Engine) that poke each service for extra info — web page titles, SMB shares, anonymous FTP, common misconfigs.

One-liner: **`-sV` identifies, `-sC` investigates.**

## Output difference
**`-sV`** fills in a VERSION column, one tidy line per port:
```
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
```

**`-sC`** keeps the port table, then hangs **indented script results** under each port:
```
80/tcp open  http
|_http-title: Welcome to Acme Corp Login
|_http-server-header: Apache/2.4.41
```
Lines starting with `|` and `|_` are script output attached to the port above. `|_` marks the last line of a script's output. Each script announces itself by name (`http-title:`).

Visual: `-sV` widens the table (VERSION column). `-sC` grows a tree *below* ports.

## The standard scan
Almost always run together — version info + script findings in one pass:
```
nmap -sC -sV -p 32677 154.57.164.82
```
(Folded into `-A`, which also adds OS detection + traceroute.) On a box with web/SMB, `-sC` often surfaces the first real lead that bare `-sV` misses.

## KEY: -sC does NOT run all scripts
`-sC` runs only the **`default`** category — a curated subset that's fast, safe, reliable, broadly useful. Lots of scripts (most `vuln`, all `brute`, anything `intrusive`) are NOT in it.

Script **categories**: `default`, `safe`, `intrusive`, `vuln`, `exploit`, `auth`, `brute`, `discovery`, ...

Restaurant analogy: `-sC` = the chef's recommended plates, not the whole menu.

## Targeting specific scripts: --script + -p
Two INDEPENDENT choices:
- **which scripts** → `--script` flag
- **which ports** → `-p` flag

```
nmap --script ftp-anon -p 21 154.57.164.82
```
Drop `-p` and the script runs against all open ports (but most scripts self-skip services they don't apply to, so it stays harmless — just add `-p` for speed + clean output).

`--script` isn't one script only:
| Form | Meaning |
|---|---|
| `--script ftp-anon,ftp-syst` | specific scripts |
| `--script "ftp-*"` | wildcard — all scripts starting `ftp-` |
| `--script vuln` | a whole category (known-vuln checks) |

`--script vuln` is a big OSCP one once you know a service + version.

## Warning: --script all
```
nmap --script all -p 21 <ip>
```
Runs EVERYTHING including `intrusive` and `exploit` scripts — can crash the target, take forever, very loud. **Don't habit this.** On the exam, blindly running `all` can knock a service over and cost you. Use targeted scripts once you know what a service is.

## Mental model
| Flag | Chooses |
|---|---|
| `-sV` | detect service versions |
| `-sC` | run the *default* script bundle |
| `--script <name>` | run *specific* scripts you name |
| `-p <port>` | which port(s) any scan targets |

`-sC` = quick first sweep. `--script` = targeted follow-up once you know the service.

## Related
- [[ss - finding internal services]]
- [[SNMP Enumeration (onesixtyone + snmpwalk)]]
- [[_MOCs/Methodology]]
