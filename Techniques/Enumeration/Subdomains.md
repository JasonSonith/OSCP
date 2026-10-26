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
- 