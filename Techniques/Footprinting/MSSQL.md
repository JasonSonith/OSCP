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
- When a admin creates a MSSQL databases, it will initially run as `NT SERVICE\MSSQLSERVER`
- 