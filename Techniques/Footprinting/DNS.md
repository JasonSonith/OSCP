---
title: DNS
type: note
permalink: oscp/techniques/footprinting/dns
---

## What is it
- Resolves computer names into IP addresses
- Information distributed over thousands of name servers
- Globally distributed DNS servers translate domain names in IP addresses
- Several types of DNS servers:
	- *DNS root server*: Starting point of DNS and does not show the final IP, tells you where to look next such as servers responsible for `.com`
	- *Authoritative name server*
	- *Non-authoritative name server*
	- *Caching server*
	- *Forwarding server*
	- *Resolver*