---
title: Untitled
type: note
permalink: oscp/boxes/cpts-labs/untitled
---
#### Ran NMAP and found these open ports
```bash
# Nmap 7.991 scan initiated Thu Oct 22 16:27:11 2026 as: nmap -oN nmap/initial 10.129.202.41
Nmap scan report for 10.129.202.41
Host is up (0.053s latency).
Not shown: 993 closed tcp ports (conn-refused)
PORT     STATE SERVICE
111/tcp  open  rpcbind
135/tcp  open  msrpc
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
2049/tcp open  nfs
3389/tcp open  ms-wbt-server
5985/tcp open  wsman

# Nmap done at Thu Oct 22 16:27:22 2026 -- 1 IP address (1 host up) scanned in 10.48 seconds
```

#### Found the `techsupport` mount
![[Pasted image 20261022181419.png]]
- This was because we found `nfs` was open

#### Mounted it to our local machine
```bash
mkdir targetNFS
sudo mount -t nfs 10.129.202.41:/TechSupport ./targetNFS -o nolock
```

#### Found credentials inside `TechSupport`
```bash
    user="alex"
     password="lol123!mD"
```
- File also said there was a `smtp` server
- `smtp` server is our next lead

#### Connect to `smtp` server
```bash
❯ smbclient -U alex -L //10.129.202.41/

Password for [WORKGROUP\alex]:

        Sharename       Type      Comment
        ---------       ----      -------
        ADMIN$          Disk      Remote Admin
        C$              Disk      Default share
        devshare        Disk
        IPC$            IPC       Remote IPC
        Users           Disk
SMB1 disabled -- no workgroup available
```

- Inside `devshare` we found a file `important.txt`
- `important.txt` had sql creds in it: `sa:87N1ns@slls83`
- 