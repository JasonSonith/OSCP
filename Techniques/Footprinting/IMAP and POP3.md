---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-1
---

## What it is
- *IMAP* (Internet Message Access Protocol) is for online management of emails on a remote server
- *POP3* grabs the main and puts a local copy on your device
- Both are accessed via port `143` but can use an alternate port `993`
- IMAP sends stuff unencrypted and in plaintext

## Default Configuration
- `dovecot-imapd` and `dovecot-pop3d` using `apt` are used to install IMAP/POP3 

#### IMAP commands

|**Command**|**Description**|
|---|---|
|`1 LOGIN username password`|User's login.|
|`1 LIST "" *`|Lists all directories.|
|`1 CREATE "INBOX"`|Creates a mailbox with a specified name.|
|`1 DELETE "INBOX"`|Deletes a mailbox.|
|`1 RENAME "ToRead" "Important"`|Renames a mailbox.|
|`1 LSUB "" *`|Returns a subset of names from the set of names that the User has declared as being `active` or `subscribed`.|
|`1 SELECT INBOX`|Selects a mailbox so that messages in the mailbox can be accessed.|
|`1 UNSELECT INBOX`|Exits the selected mailbox.|
|`1 FETCH <ID> all`|Retrieves data associated with a message in the mailbox.|
|`1 CLOSE`|Removes all messages with the `Deleted` flag set.|
|`1 LOGOUT`|Closes the connection with the IMAP server.|

#### POP3 Commands

|**Command**|**Description**|
|---|---|
|`USER username`|Identifies the user.|
|`PASS password`|Authentication of the user using its password.|
|`STAT`|Requests the number of saved emails from the server.|
|`LIST`|Requests from the server the number and size of all emails.|
|`RETR id`|Requests the server to deliver the requested email by ID.|
|`DELE id`|Requests the server to delete the requested email by ID.|
|`CAPA`|Requests the server to display the server capabilities.|
|`RSET`|Requests the server to reset the transmitted information.|
|`QUIT`|Closes the connection with the POP3 server.|

---

## Dangerous Settings
|**Setting**|**Description**|
|---|---|
|`auth_debug`|Enables all authentication debug logging.|
|`auth_debug_passwords`|This setting adjusts log verbosity, the submitted passwords, and the scheme gets logged.|
|`auth_verbose`|Logs unsuccessful authentication attempts and their reasons.|
|`auth_verbose_passwords`|Passwords used for authentication are logged and can also be truncated.|
|`auth_anonymous_username`|This specifies the username to be used when logging in with the ANONYMOUS SASL mechanism.|

---

## Foot printing the Service
- Ports used for *IMAP*: `143` and `993`
- Ports used for *POP3*: `110` and `995`

#### NMAP
```
SonithGT@htb[/htb]$ sudo nmap 10.129.14.128 -sV -p110,143,993,995 -sC

Starting Nmap 7.80 ( https://nmap.org ) at 2021-09-19 22:09 CEST
Nmap scan report for 10.129.14.128
Host is up (0.00026s latency).

PORT    STATE SERVICE  VERSION
110/tcp open  pop3     Dovecot pop3d
|_pop3-capabilities: AUTH-RESP-CODE SASL STLS TOP UIDL RESP-CODES CAPA PIPELINING
| ssl-cert: Subject: commonName=mail1.inlanefreight.htb/organizationName=Inlanefreight/stateOrProvinceName=California/countryName=US
| Not valid before: 2021-09-19T19:44:58
|_Not valid after:  2295-07-04T19:44:58
143/tcp open  imap     Dovecot imapd
|_imap-capabilities: more have post-login STARTTLS Pre-login capabilities LITERAL+ LOGIN-REFERRALS OK LOGINDISABLEDA0001 SASL-IR ENABLE listed IDLE ID IMAP4rev1
| ssl-cert: Subject: commonName=mail1.inlanefreight.htb/organizationName=Inlanefreight/stateOrProvinceName=California/countryName=US
| Not valid before: 2021-09-19T19:44:58
|_Not valid after:  2295-07-04T19:44:58
993/tcp open  ssl/imap Dovecot imapd
|_imap-capabilities: more have post-login OK capabilities LITERAL+ LOGIN-REFERRALS Pre-login AUTH=PLAINA0001 SASL-IR ENABLE listed IDLE ID IMAP4rev1
| ssl-cert: Subject: commonName=mail1.inlanefreight.htb/organizationName=Inlanefreight/stateOrProvinceName=California/countryName=US
| Not valid before: 2021-09-19T19:44:58
|_Not valid after:  2295-07-04T19:44:58
995/tcp open  ssl/pop3 Dovecot pop3d
|_pop3-capabilities: AUTH-RESP-CODE USER SASL(PLAIN) TOP UIDL RESP-CODES CAPA PIPELINING
| ssl-cert: Subject: commonName=mail1.inlanefreight.htb/organizationName=Inlanefreight/stateOrProvinceName=California/countryName=US
| Not valid before: 2021-09-19T19:44:58
|_Not valid after:  2295-07-04T19:44:58
MAC Address: 00:00:00:00:00:00 (VMware)

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 12.74 seconds
```
- From the output, the common name `mail1.inlanefreight.htb` and email server belong to the `Inlanefreight` organization: `commonName=mail1.inlanefreight.htb/organizationName=Inlanefreight/stateOrProvinceName=California/countryName=US`

#### cURL
```bash
SonithGT@htb[/htb]$ curl -k 'imaps://10.129.14.128' --user user:p4ssw0rd

* LIST (\HasNoChildren) "." Important
* LIST (\HasNoChildren) "." INBOX
```
- If we use the `-v` option we can see TLS, SSL certs, and/or banner

#### Interacting through `openssl` with POP3
```bash
SonithGT@htb[/htb]$ openssl s_client -connect 10.129.14.128:pop3s

CONNECTED(00000003)
Can't use SSL_get_servername
depth=0 C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Customer Support, CN = mail1.inlanefreight.htb, emailAddress = cry0l1t3@inlanefreight.htb
verify error:num=18:self signed certificate
verify return:1
depth=0 C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Customer Support, CN = mail1.inlanefreight.htb, emailAddress = cry0l1t3@inlanefreight.htb
verify return:1
---
Certificate chain
 0 s:C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Customer Support, CN = mail1.inlanefreight.htb, emailAddress = cry0l1t3@inlanefreight.htb

...SNIP...

---
read R BLOCK
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: 3CC39A7F2928B252EF2FFA5462140B1A0A74B29D4708AA8DE1515BB4033D92C2
    Session-ID-ctx:
    Resumption PSK: 68419D933B5FEBD878FF1BA399A926813BEA3652555E05F0EC75D65819A263AA25FA672F8974C37F6446446BB7EA83F9
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - d7 86 ac 7e f3 f4 95 35-88 40 a5 b5 d6 a6 41 e4   ...~...5.@....A.
    0010 - 96 6c e6 12 4f 50 ce 72-36 25 df e1 72 d9 23 94   .l..OP.r6%..r.#.
    0020 - cc 29 90 08 58 1b 57 ab-db a8 6b f7 8f 31 5b ad   .)..X.W...k..1[.
    0030 - 47 94 f4 67 58 1f 96 d9-ca ca 56 f9 7a 12 f6 6d   G..gX.....V.z..m
    0040 - 43 b9 b6 68 de db b2 47-4f 9f 48 14 40 45 8f 89   C..h...GO.H.@E..
    0050 - fa 19 35 9c 6d 3c a1 46-5c a2 65 ab 87 a4 fd 5e   ..5.m<.F\.e....^
    0060 - a2 95 25 d4 43 b8 71 70-40 6c fe 6f 0e d1 a0 38   ..%.C.qp@l.o...8
    0070 - 6e bd 73 91 ed 05 89 83-f5 3e d9 2a e0 2e 96 f8   n.s......>.*....
    0080 - 99 f0 50 15 e0 1b 66 db-7c 9f 10 80 4a a1 8b 24   ..P...f.|...J..$
    0090 - bb 00 03 d4 93 2b d9 95-64 44 5b c2 6b 2e 01 b5   .....+..dD[.k...
    00a0 - e8 1b f4 a4 98 a7 7a 7d-0a 80 cc 0a ad fe 6e b3   ......z}......n.
    00b0 - 0a d6 50 5d fd 9a b4 5c-28 a4 c9 36 e4 7d 2a 1e   ..P]...\(..6.}*.

    Start Time: 1632081313
    Timeout   : 7200 (sec)
    Verify return code: 18 (self signed certificate)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
+OK HTB-Academy POP3 Server
```

#### Interaction through `openssl` with IMAP
```bash

```