---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-5
---
## Overview
- Resolves domains to IP addresses
- How it works:
	1) Computer asks for DNS query
	2) DNS resolver checks its map recursively
	3) Root Name server points the way
	4) TLD Name server points it down
	5) Authoritative Name server delivers the address
	6) DNS resolver returns the Information 
	7) Computer connects
---
## Host files
- File that maps hostnames to IP addresses 
- On *Windows* it is in `C:\Windows\System32\drivers\etc\hosts`
- On *Linux* it is in `/etc/hosts`

#### Example host file
```txt
127.0.0.1       localhost
192.168.1.10    devserver.local
```

---
## Key DNS Concepts
- In DNS a *zone* is part of the domain namespace that specifies a container for a set of domain names
	- `example.com` could have `mail.example.com`, `blog.example.com`, etc

#### Example zone file
```txt
$TTL 3600 ; Default Time-To-Live (1 hour)
@       IN SOA   ns1.example.com. admin.example.com. (
                2024060401 ; Serial number (YYYYMMDDNN)
                3600       ; Refresh interval
                900        ; Retry interval
                604800     ; Expire time
                86400 )    ; Minimum TTL

@       IN NS    ns1.example.com.
@       IN NS    ns2.example.com.
@       IN MX 10 mail.example.com.
www     IN A     192.0.2.1
mail    IN A     198.51.100.1
ftp     IN CNAME www.example.com.
```
- Defines authoritative name servers, *NS records*, *MX records*, and *A records* (ip address)

### Other DNS concepts
|DNS Concept|Description|Example|
|---|---|---|
|`Domain Name`|A human-readable label for a website or other internet resource.|`www.example.com`|
|`IP Address`|A unique numerical identifier assigned to each device connected to the internet.|`192.0.2.1`|
|`DNS Resolver`|A server that translates domain names into IP addresses.|Your ISP's DNS server or public resolvers like Google DNS (`8.8.8.8`)|
|`Root Name Server`|The top-level servers in the DNS hierarchy.|There are 13 root servers worldwide, named A-M: `a.root-servers.net`|
|`TLD Name Server`|Servers responsible for specific top-level domains (e.g., .com, .org).|[Verisign](https://en.wikipedia.org/wiki/Verisign) for `.com`, [PIR](https://en.wikipedia.org/wiki/Public_Interest_Registry) for `.org`|
|`Authoritative Name Server`|The server that holds the actual IP address for a domain.|Often managed by hosting providers or domain registrars.|
|`DNS Record Types`|Different types of information stored in DNS.|A, AAAA, CNAME, MX, NS, TXT, etc.|
### Types of Records
|Record Type|Full Name|Description|Zone File Example|
|---|---|---|---|
|`A`|Address Record|Maps a hostname to its IPv4 address.|`www.example.com.` IN A `192.0.2.1`|
|`AAAA`|IPv6 Address Record|Maps a hostname to its IPv6 address.|`www.example.com.` IN AAAA `2001:db8:85a3::8a2e:370:7334`|
|`CNAME`|Canonical Name Record|Creates an alias for a hostname, pointing it to another hostname.|`blog.example.com.` IN CNAME `webserver.example.net.`|
|`MX`|Mail Exchange Record|Specifies the mail server(s) responsible for handling email for the domain.|`example.com.` IN MX 10 `mail.example.com.`|
|`NS`|Name Server Record|Delegates a DNS zone to a specific authoritative name server.|`example.com.` IN NS `ns1.example.com.`|
|`TXT`|Text Record|Stores arbitrary text information, often used for domain verification or security policies.|`example.com.` IN TXT `"v=spf1 mx -all"` (SPF record)|
|`SOA`|Start of Authority Record|Specifies administrative information about a DNS zone, including the primary name server, responsible person's email, and other parameters.|`example.com.` IN SOA `ns1.example.com. admin.example.com. 2024060301 10800 3600 604800 86400`|
|`SRV`|Service Record|Defines the hostname and port number for specific services.|`_sip._udp.example.com.` IN SRV 10 5 5060 `sipserver.example.com.`|
|`PTR`|Pointer Record|Used for reverse DNS lookups, mapping an IP address to a hostname.|`1.2.0.192.in-addr.arpa.` IN PTR `www.example.com.`|