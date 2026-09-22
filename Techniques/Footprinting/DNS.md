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

- DNS stores and outputs information about services associated with the domain
	- Can be used to see what email server serves the domain and what the domain's name servers are called
![[Pasted image 20260921205407.png]]

## DNS Record

| DNS record | Description                                                                                                                                                             |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `A`        | Returns the requested IPv$ address                                                                                                                                      |
| `AAAA`     | Returns the requested IPv6 address                                                                                                                                      |
| `MX`       | Returns the responsible mail servers                                                                                                                                    |
| `NS`       | Returns the DNS servers (nameservers) of the domain                                                                                                                     |
| `TXT`      | Contains info such as validating Google Search Console or validate SSL certs. Checks for SPF and DMARC as well                                                          |
| `CNAME`    | Serves as alias for another domain name. To visit `www.hackthebox.edu` you need to create the A record for `hackthebox.eu` and the CNAME record for `www.hackthebox.eu` |
| `PTR`      | Coverts IP to domain                                                                                                                                                    |
| `SOA`      | Provides info about DNS zone and email address of the administrative contact                                                                                            |
### SOA example
![[Pasted image 20260921210705.png]]
- In this example the email address of the administrator is `awsdns-hostmaster@amazon.com`

## Default Configuration
- All DNS servers work with three different types of configuration files
	1) Local DNS configuration files
	2) zone files
	3) reverse name resolution files
- The DNS server *Bind9* is usually served in linux based distributions
	- It's local config file name is `named.conf` which is divided in two sections (optional for general settings and zone entries for individual domains)
	- Those local config files are usually `named.conf.local` , `named.conf.options`, and `named.conf.log`
	- `name.conf` is divided in serveral options that control the behavior of the name server such as `global options` and `zone options`
- Global options are general and affect all zones
- If a option is global and zone specific then the zone option takes priority

## Local DNS Configuration
![[Pasted image 20260921212706.png]]
- In this file we can define different zones which are then divided into individual files
- A *zone file* is what the DNS server checks before it gives back the answer
- If a zone file has a syntax error, the DNS server may respond to a client with `SERVFAIL`

#### How it works
```
DNS query
    ↓
"Where is www.example.com?"
    ↓
DNS server checks zone file
    ↓
Finds www.example.com -> 1.2.3.4
    ↓
Returns 1.2.3.4
```

## Zone Files
![[Pasted image 20260921213626.png]]
- `$ORIGIN domain.com` means assume each name ends with `.domain.com` that is short
	- `server1` really means `server1.domain.com`
- `$TTL 86400` means Time To Live and tells the DNS server to cache it for 86,400 seconds
- the SOA here contains information about the DNS zone `dns1.domain.com`, the main server `hostmaster.domain.com`, the registered email `hostmaster@domain.com`, the numbers controlling DNS syncing and caching, and the Mail exchange servers (`mx.domain.com` and `mx2.domain.com`)

#### Reverse Name Resolution Files
![[Pasted image 20260921214831.png]]
- For a FQDN to resolved to a IP address, the DNS server must have a reverse lookup file

## Dangerous Settings
- Functionality usually takes priority over security so things are released early with vulnerabilities
- `allow-query` defines which hosts are allowed to send requests to the DNS server
- `allow-recursion`: Defines which hosts are allowed to send recursive requests to DNS server
- `zone-statistics`: Collects statistical data of zones

## Footprinting the Service
- Footprinting is done as the result of the requests we send

#### Using DIG NS query
![[Pasted image 20260921233624.png]]
- Shows which DNS server is responsible for domain
- Here `inlanefreight.htb` is responsible which resolves to `10.129.34.136`

#### DIG version Query
![[Pasted image 20260921233709.png]]
- what version the software is running
- The example returned `9.10.6-P1`

#### Dig - ANY Query
![[Pasted image 20260921234042.png]]
- Gives all availiable DNS information such as TXT, SOA, NS, A but does not guarantee every DNS record

#### DIG - AXFR Zone Transfer
![[Pasted image 20260921234206.png]]
- Sends the entire DNS zone file and in this case we got `app.inlanefreight.htb`, `internal.inlanefreight.htb`, `mail1.inlanefreight.htb`, `ns.inlanefreight.htb` with their IP addresses

#### DIG - AXFR Zone Transfer - Internal
![[Pasted image 20260921234424.png]]
- Same exact idea as previous AXFR but the difference you're requesting internal domains such as `internal.inlanefreight.htb`
- It also exposes internal machines such as `dc1.inlanefreight.htb`, `vpn.inlanefreight.htb`, `wsus..inlanefreight.htb` with their internal IPs just to name a few
#### Subdomain brute forcing
```bash
for sub in $(cat subdomains.txt); do
    dig $sub.inlanefreight.htb @$$ip
done
```
- takes a wordlist 