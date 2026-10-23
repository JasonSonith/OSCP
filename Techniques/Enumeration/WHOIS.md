---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-3
---
## Overview
- Database that stores information about internet resources
- Associated with *domain names*
	- Can also provide details about *Ip address blocks and autonomous systems*
```bash
SonithGT@htb[/htb]$ whois inlanefreight.com

[...]
Domain Name: inlanefreight.com
Registry Domain ID: 2420436757_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.registrar.amazon
Registrar URL: https://registrar.amazon.com
Updated Date: 2023-07-03T01:11:15Z
Creation Date: 2019-08-05T22:43:09Z
[...]
```
- *Domain Name:* The domain itself
- *Registrar:* Company where domain was registered
- *Registrant Contact:* Person or organization that registered the domain
- *Administrative Contact:* The person responsible for managing the domain
- *Technical Contact:* Person that deals with technical issues of the domain
- *Create and Expiration Dates:* When domain was registered and set to expire
- *Name Servers:* Servers that translate the domain name into an IP address

### `WHOIS` on `facebook.com`
- *Domain Registration*
	- *Registrar:* RegistrarSafe, LLV
	- *Creation Date:* 1997-03-29
	- *Expiration Date:* 2033-03-30
	- All the above show that it is with a safe LLC that has been active for a long time
- *Domain Status*:  `clientDeleteProhibited`, `clientTransferProhibited`, `clientUpdateProhibited`, `serverDeleteProhibited`, `serverTransferProhibited`, `serverUpdateProhibited`
	- This shows that facebook is protected against unauthorized changes, transfers, or deletions on both client and server side
- *Name Servers:*  `A.NS.FACEBOOK.COM`, `B.NS.FACEBOOK.COM`, `C.NS.FACEBOOK.COM`, `D.NS.FACEBOOK.COM`
	- Domain suggesting
