---
title: SMTP
type: note
permalink: oscp/techniques/footprinting/smtp
---

## Overview
- *SMTP* is a protocol for sharing emails for an IP network
- Usually on Port `25` but now on TCP port `587` 
- *SMTP* is unencrypted by nature so it is often used with SSL/TLS
- *MTA* (Mail Transfer Agent) is used as the software for sending and receiving emails
- *Open Relay Attack* usually carried out on SMTP servers with incorrect configurations
### The entire flow
```
YOU WRITE AN EMAIL
       ↓
MUA (your email app)
Sends the message
       ↓
MSA (outgoing mail server)
Checks that you're allowed to send it
       ↓
MTA (mail transfer server)
Uses DNS to find the recipient's mail server
       ↓
RECIPIENT'S MAIL SERVER
Receives the message
       ↓
MDA (mail delivery agent)
Places it in the recipient's mailbox
       ↓
RECIPIENT READS IT
```

