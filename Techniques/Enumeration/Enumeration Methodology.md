---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled
---
## Layers
### 1) Internet Presence
- Identification of internet presence and externally accessible infrastructure 
- Examples: Domains, Subdomains, vHosts, ASN Netblocks, IP Addresses (Autonomous System Number, lock block of IP addresses a system owns), Cloud Instances, Security Measures
- Goal is to identify all possible target systems and interfaces that can be tested

##### Online Presence
![[Pasted image 20260904004022.png]]
- We can look at a company's *SSL certificate* from the company's main site and often including more than just a subdomain
- [crt.sh](https://crt.sh/) can be used to find more subdomains:
![[Pasted image 20260904005602.png]]

#### Results can be outted in JSON Format as well
```bash
curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq .
```

##### Outputs
![[Pasted image 20260904005714.png]]

#### Command to filter by strictly subdomains
```bash
curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq . | grep name | cut -d":" -f2 | grep -v "CN=" | cut -d'"' -f2 | awk '{gsub(/\\n/,"\n");}1;' | sort -u
```

#### Getting Company Hosted Servers
```bash
for i in $(cat subdomainlist);do host $i | grep "has address" | grep inlanefreight.com | cut -d" " -f1,4;done
```

##### Output
![[Pasted image 20260904005951.png]]

### 2) Gateway
- All possible security measures to protect the company's external and internal infrastructure
- Examples: Firewalls, DMZ, IPS/IDS, EDR, Proxies, NAC, Network Segmentation, VPN, Cloudflare
- Goal is to understanding what we are dealing with and what to watch out for

### 3) Accessible Services
- Identify accessible interfaces and services that are hosted externally or internally
- Examples: Service Type, Functionality, Configuration Port, Version, Interfaces
- Goal is understand the reason and functionality of the target system and gain the necessary knowledge to communicate with it and exploit it effectively

### 4) Processes
- Identify the internal processes, sources, and destination associated with the services
- Examples: PID, Processed Data, Tasks, Source, Destination
- Goal is to understand these processes and their dependencies between them

### 5) Privileges
- Identification of internal permissions and privileges to the accessible services 
- Examples: Groups, Users, Permissions, Restrictions, Environment
- Goal is to understand what certain users/groups are capable of doing with their privileges 

### 6) OS Setup
- Identification of internal components and systems setup
- OS Type, patch level, network config, operating system environment, config files, sensitive private files
- Goal here is to see how administrators manage the systems and what sensitive internal information we can get from them 