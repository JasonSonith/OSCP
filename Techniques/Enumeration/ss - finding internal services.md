---
title: ss - finding internal services
type: technique
permalink: oscp/techniques/enumeration/ss-finding-internal-services
tags:
- enumeration
- post-exploitation
- pivoting
- linux
---
# ss - finding internal services

**Phase:** Post-exploitation / local enumeration
**When:** Right after getting a shell on a Linux target. Reveals services that an external `nmap` scan cannot see.

## What it does
`ss` = "socket statistics" — lists network connections and listening services on a host.

Common invocation:
```
ss -tlnp
```
- `-t` TCP
- `-l` listening sockets only
- `-n` numeric (don't resolve port numbers to names)
- `-p` show the owning process

Reads as: "show every TCP port this box is listening on, and who owns it."

## Reading the output
Every socket has two ends = two columns:
- **Local Address:Port** = *this* machine's end (the door the service waits behind).
- **Peer Address:Port** = the *remote* end (who's connected).

For a `LISTEN` socket there's no peer yet, so Peer shows a wildcard:
- `0.0.0.0:*` (IPv4) or `[::]:*` (IPv6) = "accept from any address, any port."

## Why Local Address is the key column
It tells you *who can reach* the service:

| Local Address | Reachable from | Meaning |
|---|---|---|
| `0.0.0.0` / `*` | anywhere routable | network-facing |
| specific IP (e.g. `10.x`, VPN range) | that network | interface-bound |
| `127.0.0.1` / `127.0.0.53%lo` | the machine itself only | **loopback / localhost** |

## The pentest payoff
Services bound to `127.0.0.1` are **invisible to an external nmap scan** — nmap comes from your attack box, and loopback only accepts connections originating on the target. But once you're *on* the box, `ss -tlnp` exposes them.

A localhost-only service (internal DB, admin panel, internal web app — often running as root) is frequently the next step:
- → [[Privilege Escalation]] target
- → reach it from your own box with [[Port Forwarding]] (tunnel the local-only port out through your shell)

**Mental model:** Local Address = attack surface. `0.0.0.0`/`*`/routable = reachable now. `127.0.0.1` = hidden treasure, only reachable from inside.

## Related
- [[Port Forwarding]]
- [[Privilege Escalation]]
- [[Methodology]]
