---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-4
---
## Overview
- Extensions of main domains
- Examples include `blog.example.com`, `shop.example.com`, etc

---
## Importance for Web Recon
- You know development environment of the website and exploit vulnerabilities specific to tech stack
- *Hidden login portals* under other subdomains
- *Legacy Applications* on older subdomains usually have known vulnerabilities
- *Sensitive Information* from exposed confidentials documents in subdomains

---
## Subdomain Enumeration
- Subdomains usually represented by `A` records or `AAAA` for IPv6
- `CNAME` records could be used for subdomain aliases

### Active Subdomain Enumeration
- This is interacting with target's DNS server to find subdomains
- One method is trying *DNS zone transfer* which is where a misconfigured server leaks complete list of subdomains (rarely successful)
- *Brute Force Enumeration* is more common which is using a wordlist to enumerate potential subdomains using `dnsenum`, `ffuf`, or `gobuster`

*Passive Enumeration*
- Use *Certificate Transparency logs* (CT logs) with is a public repo of SSL/TLS certs
	- Could show potential subdomains
- *Using google or DuckDuckGo* 