---
title: DNS Footprinting
type: box_note
permalink: oscp/boxes/cpts-labs/dns-footprinting
platform: HTB Academy
module: Footprinting
section_id: 1069
status: completed
target_ip_at_time: 10.129.192.91
lab_url: https://academy.hackthebox.com/app/module/112/section/1069
tags:
- box
- cpts-lab
- dns
- footprinting
- linux
---

# DNS Footprinting

> The target IP changes when the lab is reset. For this run, it was `10.129.192.91`.

## Goal

Use DNS to find:

- The TXT flag
- The IP address for `DC1`
- The full domain name whose IP ends in `.203`

## Steps I took

### 1) Saved the target IP in a variable

```bash
export ip=10.129.192.91
```

Using `$ip` means I do not have to type the IP in every command.

### 2) Scanned the target

```bash
nmap -Pn $ip
```

Port `53` was open. Port 53 is used for DNS, so I started checking the DNS server.

### 3) Asked for the name server

```bash
dig NS inlanefreight.htb @$ip
```

The server returned:

```text
ns.inlanefreight.htb
```

The `@` tells `dig` which DNS server to ask.

### 4) Tried a zone transfer on the main domain

```bash
dig AXFR inlanefreight.htb @$ip
```

A zone transfer asks the DNS server for all records in a zone. This server allowed it.

The useful records were:

```text
app.inlanefreight.htb       10.129.18.15
dev.inlanefreight.htb       10.12.0.1
internal.inlanefreight.htb  10.129.1.6
mail1.inlanefreight.htb     10.129.18.201
```

The important discovery was the second zone named `internal.inlanefreight.htb`.

### 5) Tried a zone transfer on the internal zone

```bash
dig AXFR internal.inlanefreight.htb @$ip
```

This transfer also worked. It returned the flag in a TXT record:

```text
HTB{DN5_z0N3_7r4N5F3r_iskdufhcnlu34}
```

It also returned the record for `DC1`:

```text
dc1.internal.inlanefreight.htb  10.129.34.16
```

### 6) Brute-forced the dev zone

The `dev.inlanefreight.htb` zone did not give me everything through a zone transfer, so I used `dnsenum` with the Fierce DNS wordlist.

```bash
dnsenum \
  --dnsserver $ip \
  --enum \
  -p 0 \
  -s 0 \
  -f /usr/share/wordlists/seclists/Discovery/DNS/fierce-hostlist.txt \
  dev.inlanefreight.htb
```

This found:

```text
dev1.dev.inlanefreight.htb   10.12.3.6
win2k.dev.inlanefreight.htb  10.12.3.203
```

The host whose IP ends in `.203` is `win2k.dev.inlanefreight.htb`.

## Answers

### TXT record

```text
HTB{DN5_z0N3_7r4N5F3r_iskdufhcnlu34}
```

### IPv4 address of DC1

```text
10.129.34.16
```

### FQDN of the host whose IP ends in .203

```text
win2k.dev.inlanefreight.htb
```

## What I learned

- `AXFR` means DNS zone transfer.
- A badly configured DNS server may give away every record in a zone.
- A zone transfer can reveal another zone that also needs to be checked.
- If a zone transfer is blocked, brute-force DNS names with a wordlist.
- Keep sending DNS requests to the lab target IP after `@`. Do not switch to an IP found inside a DNS record.

## Related note

[[DNS]]