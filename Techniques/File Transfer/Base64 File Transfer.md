---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1
tags:
- template
---

# Base64 File Transfer

## What it is
- Remote hosts can have firewall protections to prevent file download on our machine so use *base64* to encode the file

## How to use it
#### Encode the file on attacker machine
```bash
base64 shell -w 0
```
- `-w 0` sets wrap width to 0 because base64 adds a new line every 76 characters

#### Decode on Target machine
```bash
echo <base64 string> | base64 -d > shell
```
---
title: Base64 File Transfer
type: note
permalink: oscp/techniques/Base64 File Transfer
---