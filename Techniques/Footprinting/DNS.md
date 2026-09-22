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
	- *Non-authoritative name server*: A server that knows an answer but not the official source. Usually learned the answer from another DNS server and saves it temporarily
	- *Caching server*: Remembers previous DNS answers so it can respond quickly
	- *Forwarding server*: Passes the responsibility to another DNS server
	- *Resolver*: Part that does the work of finding the answer and asks DNS on your behalf and returns the final IP address

- DNS is mainly unencrypted
	- Devices on a local WLAN and internet provides and hack in and spy on queries
	- Things like DNS over TLS *DoT*, DNS over HTTPS *DoH*, and *DNSCrypt* (encrypts traffic over name server) are used over the server