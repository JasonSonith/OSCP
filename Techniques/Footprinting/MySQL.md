---
title: MySQL
type: note
permalink: oscp/techniques/footprinting/my-sql
---

## Overview
- MySQL works through the *client-server principle* (client -> SQL query -> mySQL server)

### MySQL Databases
- Used in combination with Linux, Apache, MySQL, PHP (LAMP) or using *Nginx* over Apache (LEMP)
- MySQL acts as website's central storage and PHP scripts retrieve the data to build pages and handle request
---
## Default Configuration
```bash
SonithGT@htb[/htb]$ sudo apt install mysql-server -y
SonithGT@htb[/htb]$ cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep -v "#" | sed -r '/^\s*$/d'

[client]
port        = 3306
socket      = /var/run/mysqld/mysqld.sock

[mysqld_safe]
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
nice        = 0

[mysqld]
skip-host-cache
skip-name-resolve
user        = mysql
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
port        = 3306
basedir     = /usr
datadir     = /var/lib/mysql
tmpdir      = /tmp
lc-messages-dir = /usr/share/mysql
explicit_defaults_for_timestamp

symbolic-links=0

!includedir /etc/mysql/conf.d/
```