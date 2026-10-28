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

; <<>> DiG 9.18.12-1~bpo11+1-Debian <<>> axfr @nsztm1.digi.ninja zonetransfer.me
; (1 server found)
;; global options: +cmd
zonetransfer.me.    7200    IN  SOA nsztm1.digi.ninja. robin.digi.ninja. 2019100801 172800 900 1209600 3600
zonetransfer.me.    300 IN  HINFO   "Casio fx-700G" "Windows XP"
zonetransfer.me.    301 IN  TXT "google-site-verification=tyP28J7JAUHA9fw2sHXMgcCC0I6XBmmoVi04VlMewxA"
zonetransfer.me.    7200    IN  MX  0 ASPMX.L.GOOGLE.COM.
...
zonetransfer.me.    7200    IN  A   5.196.105.14
zonetransfer.me.    7200    IN  NS  nsztm1.digi.ninja.
zonetransfer.me.    7200    IN  NS  nsztm2.digi.ninja.
_acme-challenge.zonetransfer.me. 301 IN TXT "6Oa05hbUJ9xSsvYy7pApQvwCUSSGgxvrbdizjePEsZI"
_sip._tcp.zonetransfer.me. 14000 IN SRV 0 0 5060 www.zonetransfer.me.
14.105.196.5.IN-ADDR.ARPA.zonetransfer.me. 7200 IN PTR www.zonetransfer.me.
asfdbauthdns.zonetransfer.me. 7900 IN   AFSDB   1 asfdbbox.zonetransfer.me.
asfdbbox.zonetransfer.me. 7200  IN  A   127.0.0.1
asfdbvolume.zonetransfer.me. 7800 IN    AFSDB   1 asfdbbox.zonetransfer.me.
canberra-office.zonetransfer.me. 7200 IN A  202.14.81.230
...
;; Query time: 10 msec
;; SERVER: 81.4.108.41#53(nsztm1.digi.ninja) (TCP)
;; WHEN: Mon May 27 18:31:35 BST 2024
;; XFR size: 50 records (messages 1, bytes 2085)
```
- This tells the dig command to request a full zone transfer for `zonetransfer.me`