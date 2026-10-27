---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-7
---
## Overview
- *Virtual Hosts* exists without a DNS record which unlike a subdomain by using the *HTTP Host* header 
- *vhost fuzzing* is a way to discover non-public subdomains

#### Vhost config in Apache
```apacheconf
# Example of name-based virtual host configuration in Apache
<VirtualHost *:80>
    ServerName www.example1.com
    DocumentRoot /var/www/example1
</VirtualHost>

<VirtualHost *:80>
    ServerName www.example2.org
    DocumentRoot /var/www/example2
</VirtualHost>

<VirtualHost *:80>
    ServerName www.another-example.net
    DocumentRoot /var/www/another-example
</VirtualHost>
```


