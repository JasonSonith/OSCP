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

## Samba
- Implements *CIFS* network protocol (COmmon Internet File System)
- Aligned with SMB version 1
- Connections occur over TCP ports `137` and `138` and `139`
- CIFS operates on `445` exclusively
- SMB 2 and SMB 3 are newer

|**SMB Version**|**Supported**|**Features**|
|---|---|---|
|CIFS|Windows NT 4.0|Communication via NetBIOS interface|
|SMB 1.0|Windows 2000|Direct connection via TCP|
|SMB 2.0|Windows Vista, Windows Server 2008|Performance upgrades, improved message signing, caching feature|
|SMB 2.1|Windows 7, Windows Server 2008 R2|Locking mechanisms|
|SMB 3.0|Windows 8, Windows Server 2012|Multichannel connections, end-to-end encryption, remote storage access|
|SMB 3.0.2|Windows 8.1, Windows Server 2012 R2||
|SMB 3.1.1|Windows 10, Windows Server 2016|Integrity checking, AES-128 encryption|
- SMB 3 allows the samba server to gain the ability to be a full member of Active Directory
- SMB 4 allows Samba to have a AD domain controller
- In a network, each host is apart of the same workgroup
- IBM developed in API for the *Network Basic Input/Output System (NetBIOS)* that provides a blueprint for application to connect and share data with other computers
	- When a machine goes online it needs a name so it goes through the *name registration* procedure

## Default Configuration

#### Filled out Default Settings


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
