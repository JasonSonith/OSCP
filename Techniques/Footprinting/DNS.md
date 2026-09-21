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
	- *Authoritative name server*: Official source for a domain's DNS information. For example, it holds the real DNS records for `example.com`
	- *Non-authoritative name server*: A server that knows an answer but not the official source. Usually learn
	- *Caching server*
	- *Forwarding server*
	- *Resolver*