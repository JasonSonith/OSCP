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

### 2) Gateway
- All possible security measures to protect the company's external and internal infrastructure
- Examples: Firewalls, DMZ, IPS/IDS, EDR, Proxies, NAC, Network Segmentation, VPN, Cloudflare

### 3) Accessible Services
- Identify accessible interfaces and services that are hosted externally or internally
- Examples: Service Type, Functionality, Configuration Port, Version, Interfaces

### 4) Processes
- Identify the internal processes, sources, and destination associated with the services
- Examples: PID, Processed Data, Tasks, Source, Destination

### 5) Privileges
- Identification of internal permissions and privileges to the accessible services 
- Examples: Groups, Users, Permissions, Restrictions, Environment

### 6) OS Setup
- Identification of internal components and systems setup
- OS Type, patch level, network config, operating system environment, config files, sensitive private files