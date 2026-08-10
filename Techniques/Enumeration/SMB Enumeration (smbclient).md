---
title: SMB Enumeration (smbclient)
type: technique
permalink: oscp/techniques/enumeration/smb-enumeration-smbclient
tags:
- enumeration
- smb
- smbclient
- shares
---

# SMB Enumeration (smbclient)

**Phase:** Enumeration / recon
**Default ports:** 445 (SMB), 139 (older NetBIOS)
**When:** Ports 445/139 show up in a scan. Classic initial-foothold source.

## What SMB is (plain terms)
SMB (Server Message Block) is mainly the **Windows** way of sharing things across a network — not just files but printers, plus authentication and permissions. Less like a delivery service, more like a shared office drive with logins and folders. The unit you're after is a **share**: a named folder exposed on the network (e.g. `C$`, `ADMIN$`, or custom ones like `users` / `Backups`).

Why it matters: shares often hold sensitive files — configs, backups, sometimes passwords. A readable/writable share or an exposed config is frequently the thread that gets you in.

## Listing shares with smbclient
`smbclient` enumerates and interacts with SMB shares.
```
smbclient -N -L //10.129.42.253
```
- `-L` = **list** available shares on the host
- `-N` = **no password** (suppress the password prompt) → tests anonymous/null access

Example output:
```
Sharename       Type      Comment
---------       ----      -------
print$          Disk      Printer Drivers
users           Disk
IPC$            IPC       IPC Service (gs-svcscan server (Samba, Ubuntu))
SMB1 disabled -- no workgroup available
```
Reading it: `print$` and `IPC$` are default plumbing — **a custom share like `users` is the interesting one**. `-N` succeeding also means anonymous access works → your lead to pull.

## Connecting to a share
```
smbclient -N //10.129.42.253/users
```
Then it's an FTP-like prompt: `ls` to browse, `cd <dir>`, `get <file>` to download.

## The backslash problem (why you see \\\\)
SMB addresses are UNC paths written with backslashes: `\\10.129.42.253`. But the **Linux shell eats backslashes** — every 2 you type = 1 delivered (a backslash means "take the next char literally," so it spends itself). To get `\\` to arrive you'd type `\\\\` (4 → 2).

**Just avoid it** — two clean ways that need zero backslash math:
```
smbclient -N -L //10.129.42.253      # forward slashes: shell doesn't touch them
smbclient -N -L '\\10.129.42.253'    # single quotes: shell hands it over literally
```
Use single quotes (strong) not double (weak — still processes `$` etc). Most people just use `//`.

## UNC path structure
`\\host\share\file` — read left to right, getting more specific:
```
\\10.129.42.253\users\report.txt
  └── host ──┘└share┘└─ file ─┘
```
Leading `\\` = "this is a remote network host" (single `\` would mean local path). `\\{ip}` alone = the machine itself → that's why `-L` uses just the host: "list what this machine shares" before picking one.

## Related concepts
- **null session** = connecting to SMB with no username/password. Misconfigured hosts allow it and leak share lists / usernames. The SMB cousin of FTP anonymous login. `-N` is how you test for it.
- Other tools worth knowing: `enum4linux <ip>`, `crackmapexec smb <ip>`, `smbmap -H <ip>`.

## Enumeration angle checklist
- List shares with `-N` (anonymous). Any custom (non-default) share = investigate.
- Connect and browse readable shares for config/backup/credential files.
- Note the Comment column — often leaks OS/hostname (here: `gs-svcscan ... Samba, Ubuntu`).
- If you have creds later, re-list authenticated: `smbclient -L //ip -U username`.

## Related
- [[ss - finding internal services]]
- [[SNMP Enumeration (onesixtyone + snmpwalk)]]
- [[Nmap -sC and -sV (service + script scanning)]]
- [[Null Session]]
- [[_MOCs/Methodology]]
