---
title: box-note
type: note
permalink: oscp/templates/box-note-1
---

---
title: Service Scanning
ip: 10.129.104.219
os: Linux
difficulty: Easy
platform: CPTS Lab
status: in-progress
created: 2026-08-09
tags: [box, cpts-lab, linux]
---

# Service Scanning — 10.129.104.219

> **OS:** Linux · **Difficulty:** Easy · **Platform:** CPTS Lab · **Status:** #in-progress

---

## Recon
```bash
# nmap quick + full
nmap -sC -sV 10.129.104.219
``` 
- Open ports: `ftp`:21, `ssh`:22, `80`:http, `139`:netbios-ssn, `445`:netbios-ssn, `2323`:telnet, `8080`:http
- Services and Versions: `ftp:vsftpd 3.0.3`, `ssh:OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol`, `http(80):Apache httpd 2.4.41 ((Ubuntu))`, `http(8080): Apache Tomcat`, `netbios-ssn(139 & 445):Samba smbd 4`, `telnet: Linux telnetd`
#### Scan Results
```
# Nmap 7.98 scan initiated Sun Aug  9 23:32:17 2026 as: /usr/lib/nmap/nmap --privileged -sC -sV -oN scan.txt 10.129.104.219
Nmap scan report for 10.129.104.219
Host is up (0.037s latency).
Not shown: 993 closed tcp ports (reset)
PORT     STATE SERVICE     VERSION
21/tcp   open  ftp         vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_drwxr-xr-x    2 ftp      ftp          4096 Feb 25  2021 pub
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.10.14.163
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 3
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
22/tcp   open  ssh         OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 a0:01:d7:79:e9:d2:09:2a:b8:d9:b4:9a:6c:00:0c:1c (RSA)
|   256 2b:99:b2:1f:ec:1a:5a:c6:b7:be:b5:50:d1:0e:a9:df (ECDSA)
|_  256 e4:f8:17:8d:d4:71:d1:4e:d4:0e:bd:f0:29:4f:6d:14 (ED25519)
80/tcp   open  http        Apache httpd 2.4.41 ((Ubuntu))
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: PHP 7.4.3 - phpinfo()
139/tcp  open  netbios-ssn Samba smbd 4
445/tcp  open  netbios-ssn Samba smbd 4
2323/tcp open  telnet      Linux telnetd
8080/tcp open  http        Apache Tomcat
|_http-open-proxy: Proxy might be redirecting requests
|_http-title: Apache Tomcat
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_clock-skew: -1m23s
|_nbstat: NetBIOS name: GS-SVCSCAN, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2026-08-10T04:31:07
|_  start_date: N/A

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sun Aug  9 23:32:40 2026 -- 1 IP address (1 host up) scanned in 23.68 seconds

```

## Enumeration
- SMB / shares: `Bob:Welcome1`
- Creds / usernames found: `passwords.txt`
#### Password.txt
```
Banking:

https://acmebank.local/login.php

bobby:Surfer1010!

Network:

bob.smith@inlanefreight.local:Welcome123!


vCenter:

root:B0b_the_m@n!-rootPa$$!


```

## Techniques used
- [[SMB enumeration]]
- [[Nmap -sC and -sV (service + script scanning)]]

## Lessons learned
- *What slowed me down:* Using nmap directly on port `8080` did not work because I used the `-Pn` flag when running it
- against port `8080`. I dropped the `-Pn` flag and it worked


- *What I'd do faster next time:*
type: note
permalink: oscp/boxes/cpts-labs/Service Scanning
---