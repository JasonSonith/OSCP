---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-6
---

## Overview
- A zone transfer is a copy of all DNS records in a zoneÍ
![[Pasted image 20261026235255.png]]
- *Zone Transfer Request (AXFR):* A secondary DNS server initiates the process by sending a zone transfer request to primary server
- *SOA Record Transfer:* Primary server responds back with SOA records
- *DNS Record Transmission:* The server that transfers all DNS records in the zone to secondary server
- *Zone Transfer Complete:* Signal that transmission is done at the end of zone transfer
- *Acknowledgement (ACK):* Secondary server acknowledges that zone transfer data is done

---
## Zone Transfer Vulnerability
- Unauthorized zone transfers can reveal *subdomains*, *IP Addresses*, and *Name Server Records*

### Exploiting Zone Transfers
```bash
SonithGT@htb[/htb]$ dig axfr @nsztm1.digi.ninja zonetransfer.me
```
- This tells the dig command to request a full zone transfer for `zonetransfer.me`