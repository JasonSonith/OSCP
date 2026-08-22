---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1-1
tags:
  - template
---

# Nmap

## What it is
- Enumeration tool
- Always to get a idea of what you are attacking

## When to use
- Attacking anything with an IP

## How to test

## Things to know
- `sS` flag sends the `SYN-ACK` flag in the TCP handshake so it scans really fast
	- If the target responds with a RST flag then the port is closed
	- If Nmap does not receive a response back then it is filtered
### Scanning a network range
