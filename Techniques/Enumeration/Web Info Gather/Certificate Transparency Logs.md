---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-8
---
## Overview
- *CT logs* are public ledgers that record the issuance of SSL/TLS certificates
- Open for anyone to inspect
- CT logs allow for:
	1) Identify suspicious certificate (rogue certificate)
	2) It holds CAs accountable because if a CA issues a insecure cert, they have a loss of trust

---
## CT Logs and Web Recon
- You can see other subdomains and domains an organization might have
- The subdomains might have old certs of out of date/vulnerable configurations
