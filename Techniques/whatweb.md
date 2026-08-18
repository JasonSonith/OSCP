---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1-1
tags:
  - template
---

# whatweb

## What it is
- `whatweb` can be used to identify the web app in use


## When to use
- When pentesting a web app

## How to test
#### Command
```bash
whatweb $ip
```

##### Output of Command
```bash
http://10.129.42.190 [200 OK] Apache[2.4.18], Country[RESERVED][ZZ], HTTPServer[Ubuntu Linux][Apache/2.4.18 (Ubuntu)], IP[10.129.42.190]
```

#### Use `curl` to check out what's on the page source
```bash
curl $url
```

##### Output
```bash
<b>Hello world!</b> 
<!-- /nibbleblog/ directory. Nothing interesting here! -->
```
- This specific command mentions a directory called `nibblelog` which is worth checking

#### Checking `nibblelog`
```bash
whatweb http://10.129.42.190/nibbleblog
```

##### Output
```bash
http://10.129.42.190/nibbleblog [301 Moved Permanently] Apache[2.4.18], Country[RESERVED][ZZ], HTTPServer[Ubuntu Linux][Apache/2.4.18 (Ubuntu)], IP[10.129.42.190], RedirectLocation[http://10.129.42.190/nibbleblog/], Title[301 Moved Permanently] http://10.129.42.190/nibbleblog/ [200 OK] Apache[2.4.18], Cookies[PHPSESSID], Country[RESERVED][ZZ], HTML5, HTTPServer[Ubuntu Linux][Apache/2.4.18 (Ubuntu)], IP[10.129.42.190], JQuery, MetaGenerator[Nibbleblog], PoweredBy[Nibbleblog], Script, Title[Nibbles - Yum yum]
```
## Things to Know
![[Pasted image 20260817194409.png]] 
- Looking at page source can lead to interesting things