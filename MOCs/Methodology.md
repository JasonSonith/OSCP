---
title: Methodology MOC
tags:
- moc
- methodology
permalink: oscp/mocs/methodology
---

# Methodology MOC

> Your attack checklist. When you're stuck on a box, read top to bottom.
> Each link becomes a technique note the first time you click it.

## 1. Recon / Enumeration
- [[Nmap scanning]]
- [[Directory brute forcing]]
- [[SMB enumeration]]
- [[DNS enumeration]]
- [[Service version enumeration]]

## 2. Getting In (Foothold)
- [[SQL injection]]
- [[Local File Inclusion]]
- [[File upload bypass]]
- [[Password spraying]]
- [[Kerberoasting]]
- [[AS-REP roasting]]
- [[Default / weak credentials]]

## 3. Privilege Escalation - Linux
- [[sudo abuse]]
- [[SUID SGID binaries]]
- [[Cron job abuse]]
- [[Kernel exploits]]
- [[Capabilities abuse]]

## 4. Privilege Escalation - Windows
- [[Token / privilege abuse]]
- [[Unquoted service paths]]
- [[Weak service permissions]]
- [[Stored credentials]]
- [[AlwaysInstallElevated]]

## 5. Pivoting / Lateral Movement
- [[Port forwarding]]
- [[Pass the hash]]
- [[Chisel tunneling]]

## 6. Post-Exploitation
- [[Looting credentials]]
- [[Proof collection]]