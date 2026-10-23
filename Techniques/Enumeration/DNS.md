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