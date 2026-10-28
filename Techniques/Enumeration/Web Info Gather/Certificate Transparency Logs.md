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

---
## Searching CT Logs
|Tool|Key Features|Use Cases|Pros|Cons|
|---|---|---|---|---|
|[crt.sh](https://crt.sh/)|User-friendly web interface, simple search by domain, displays certificate details, SAN entries.|Quick and easy searches, identifying subdomains, checking certificate issuance history.|Free, easy to use, no registration required.|Limited filtering and analysis options.|
|[Censys](https://search.censys.io/)|Powerful search engine for internet-connected devices, advanced filtering by domain, IP, certificate attributes.|In-depth analysis of certificates, identifying misconfigurations, finding related certificates and hosts.|Extensive data and filtering options, API access.|Requires registration (free tier available).|
