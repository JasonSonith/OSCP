---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-2
---
## Overview
- Written to run on windows OS with strong support for *.NET*

### MSSQL Clients
- *SQL Server Management Studio* (SSMS) is an app used to connect and manage the databases of MySQL
- Impacket's `mssqlclient.py` can be used to interact with the SQL server as well

### MSSQL Databases

| Default System Database | Description                                                                                                                                                                                            |     |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| `master`                | Tracks all system information for an SQL server instance                                                                                                                                               |     |
| `model`                 | Template database that acts as a structure for every new database created. Any setting changed in the model database will be reflected in any new database created after changes to the model database |     |
| `msdb`                  | The SQL Server Agent uses this database to schedule jobs & alerts                                                                                                                                      |     |
| `tempdb`                | Stores temporary objects                                                                                                                                                                               |     |
| `resource`              | Read-only database containing system objects included with SQL server                                                                                                                                  |     |
- MSSQL ahs some default databases that make us understand the structure of all databases

---
## Default Configuration
- When a admin creates a MSSQL databases, it will initially run as `NT SERVICE\MSSQLSERVER` which is a windows account
- To connect the DB, you use windows authentication and the SQL server checks if you have permissions to access it (usually through SAM or Active Directory)

---
## Dangerous Settings
- There are lots of ways that a MSSQL database can be misconfigured but a few are:
	- MSSQL client not using encryption to connect to MSSQL server
	- Using self signed certs because it is possible to spoof them
	- Use of named pipes (`\\SERVER\pipe\sql\query`)
	- Weak and default `sa` creds, admins might've forgot to disable those accounts

--- 
## Foot printing the Service

#### NMAP MSSQL script scan
```bash
SonithGT@htb[/htb]$ sudo nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 10.129.201.248

Starting Nmap 7.91 ( https://nmap.org ) at 2021-11-08 09:40 EST
Nmap scan report for 10.129.201.248
Host is up (0.15s latency).

PORT     STATE SERVICE  VERSION
1433/tcp open  ms-sql-s Microsoft SQL Server 2019 15.00.2000.00; RTM
| ms-sql-ntlm-info: 
|   Target_Name: SQL-01
|   NetBIOS_Domain_Name: SQL-01
|   NetBIOS_Computer_Name: SQL-01
|   DNS_Domain_Name: SQL-01
|   DNS_Computer_Name: SQL-01
|_  Product_Version: 10.0.17763

Host script results:
| ms-sql-dac: 
|_  Instance: MSSQLSERVER; DAC port: 1434 (connection failed)
| ms-sql-info: 
|   Windows server name: SQL-01
|   10.129.201.248\MSSQLSERVER: 
|     Instance name: MSSQLSERVER
|     Version: 
|       name: Microsoft SQL Server 2019 RTM
|       number: 15.00.2000.00
|       Product: Microsoft SQL Server 2019
|       Service pack level: RTM
|       Post-SP patches applied: false
|     TCP port: 1433
|     Named pipe: \\10.129.201.248\pipe\sql\query
|_    Clustered: false

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 8.52 seconds
```
- This provides us information such as `hostname`, `database instance name`, `software version of MSSQL`, and if `named pipes` are enabled

#### MSSQL Ping in Metasploit
```bash
msf6 auxiliary(scanner/mssql/mssql_ping) > set rhosts 10.129.201.248

rhosts => 10.129.201.248


msf6 auxiliary(scanner/mssql/mssql_ping) > run

[*] 10.129.201.248:       - SQL Server information for 10.129.201.248:
[+] 10.129.201.248:       -    ServerName      = SQL-01
[+] 10.129.201.248:       -    InstanceName    = MSSQLSERVER
[+] 10.129.201.248:       -    IsClustered     = No
[+] 10.129.201.248:       -    Version         = 15.0.2000.5
[+] 10.129.201.248:       -    tcp             = 1433
[+] 10.129.201.248:       -    np              = \\SQL-01\pipe\sql\query
[*] 10.129.201.248:       - Scanned 1 of 1 hosts (100% complete)
[*] Auxiliary module execution completed
```
- This scans the MSSQL service to provide helpful information for us

#### Connecting with `mssqlclient.py`
```bash
SonithGT@htb[/htb]$ python3 mssqlclient.py Administrator@10.129.201.248 -windows-auth

Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

Password:
[*] Encryption required, switching to TLS
[*] ENVCHANGE(DATABASE): Old Value: master, New Value: master
[*] ENVCHANGE(LANGUAGE): Old Value: , New Value: us_english
[*] ENVCHANGE(PACKETSIZE): Old Value: 4096, New Value: 16192
[*] INFO(SQL-01): Line 1: Changed database context to 'master'.
[*] INFO(SQL-01): Line 1: Changed language setting to us_english.
[*] ACK: Result: 1 - Microsoft SQL Server (150 7208) 
[!] Press help for extra shell commands

SQL> select name from sys.databases

name                                                                                                                               

--------------------------------------------------------------------------------------

master                                                                                                                             

tempdb                                                                                                                             

model                                                                                                                              

msdb                                                                                                                               

Transactions    
```
- We can use `mssqlcli`