---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/web-info-gather/untitled
---
## Fingerprinting Techniques
- *Banner Grabbing:* Reveals servers, software, version numbers, etc
- *Analyzing HTTP Headers:* `Server` header reveals web server software and `X-Powered-By` reveals additional scripting languages/frameworks
- *Probing for Specific Responses:* Sending requests can allow the website to have information disclosure
- *Analysing Page Content:* Seeing structure can provide details about scripts and other elements

### Tools to automate the process
|Tool|Description|Features|
|---|---|---|
|`Wappalyzer`|Browser extension and online service for website technology profiling.|Identifies a wide range of web technologies, including CMSs, frameworks, analytics tools, and more.|
|`BuiltWith`|Web technology profiler that provides detailed reports on a website's technology stack.|Offers both free and paid plans with varying levels of detail.|
|`WhatWeb`|Command-line tool for website fingerprinting.|Uses a vast database of signatures to identify various web technologies.|
|`Nmap`|Versatile network scanner that can be used for various reconnaissance tasks, including service and OS fingerprinting.|Can be used with scripts (NSE) to perform more specialised fingerprinting.|
|`Netcraft`|Offers a range of web security services, including website fingerprinting and security reporting.|Provides detailed reports on a website's technology, hosting provider, and security posture.|
|`wafw00f`|Command-line tool specifically designed for identifying Web Application Firewalls (WAFs).|Helps determine if a WAF is present and, if so, its type and configuration.|

---

## Fingerprinting inlanefreight.com

#### Banner Grabbing
```bash
SonithGT@htb[/htb]$ curl -I inlanefreight.com

HTTP/1.1 301 Moved Permanently
Date: Fri, 31 May 2024 12:07:44 GMT
Server: Apache/2.4.41 (Ubuntu)
Location: https://inlanefreight.com/
Content-Type: text/html; charset=iso-8859-1
```
- We see that is running `Apache/2.4.41`

```bash
SonithGT@htb[/htb]$ curl -I https://inlanefreight.com

HTTP/1.1 301 Moved Permanently
Date: Fri, 31 May 2024 12:12:12 GMT
Server: Apache/2.4.41 (Ubuntu)
X-Redirect-By: WordPress
Location: https://www.inlanefreight.com/
Content-Type: text/html; charset=UTF-8
```
- After going for the `redirect` , `https://inlanefreight.com` it shows us that it  `WordPress` doing the redirection to `https://www.inlanefreight.com/` from the `Location` header

```bash
SonithGT@htb[/htb]$ curl -I https://www.inlanefreight.com

HTTP/1.1 200 OK
Date: Fri, 31 May 2024 12:12:26 GMT
Server: Apache/2.4.41 (Ubuntu)
Link: <https://www.inlanefreight.com/index.php/wp-json/>; rel="https://api.w.org/"
Link: <https://www.inlanefreight.com/index.php/wp-json/wp/v2/pages/7>; rel="alternate"; type="application/json"
Link: <https://www.inlanefreight.com/>; rel=shortlink
Content-Type: text/html; charset=UTF-8
```

### Wafw00f
- `wafw00f` determines if there is a `WAF`
- 