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

### Server Vhost Lookup
![[Pasted image 20261027142338.png]]
1) You enter `www.inlane.freight.com` to start a http request
2) Host header reveals domain reveals domain
3) Web server looks at *virtual host config* to find vhost
4) Web server serves the vhost back to browser
---

## Types of Virtual Hosting

- *Name Based Virtual Hosting:* Uses `HTTP host header` to distinguish between websites
- *IP Based Virtual Hosting:* Assigns IP to each website on server
- *Port-Based Virtual Hosting:* Different websites have different ports on the same IP address 
	- Example: One on port 80 and another on 8080

---
## Virtual Host Discovery Tools
|Tool|Description|Features|
|---|---|---|
|[gobuster](https://github.com/OJ/gobuster)|A multi-purpose tool often used for directory/file brute-forcing, but also effective for virtual host discovery.|Fast, supports multiple HTTP methods, can use custom wordlists.|
|[Feroxbuster](https://github.com/epi052/feroxbuster)|Similar to Gobuster, but with a Rust-based implementation, known for its speed and flexibility.|Supports recursion, wildcard discovery, and various filters.|
|[ffuf](https://github.com/ffuf/ffuf)|Another fast web fuzzer that can be used for virtual host discovery by fuzzing the `Host` header.|Customizable wordlist input and filtering options.|
#### Gobuster
```bash
SonithGT@htb[/htb]$ gobuster vhost -u http://<target_IP_address> -w <wordlist_file> --append-domain
```
- ``