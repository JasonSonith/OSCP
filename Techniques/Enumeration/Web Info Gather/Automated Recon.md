---
permalink: oscp/techniques/enumeration/web-info-gather/untitled-3
title: Untitled
type: note
---
## FinalRecon
- Reveals *Header Information*
- Does a `WHOIS` lookup
- Reveals *SSL certificate information*
- Has a *Crawler* that looks for vulnerabilities in html css javascript, internal/external links, robots.txt, and wayback machine data
- Offers DNS, subdomain, and directory enumeration

---
## Downloading FinalRecon
```bash
SonithGT@htb[/htb]$ git clone https://github.com/thewhiteh4t/FinalRecon.git
SonithGT@htb[/htb]$ cd FinalRecon
SonithGT@htb[/htb]$ pip3 install -r requirements.txt
SonithGT@htb[/htb]$ chmod +x ./finalrecon.py
SonithGT@htb[/htb]$ ./finalrecon.py --help
```

### Things in `./finalrecon.py --help`

| Option         | Argument | Description                                         |
| -------------- | -------- | --------------------------------------------------- |
| `-h`, `--help` |          | Show the help message and exit.                     |
| `--url`        | URL      | Specify the target URL.                             |
| `--headers`    |          | Retrieve header information for the target URL.     |
| `--sslinfo`    |          | Get SSL certificate information for the target URL. |
| `--whois`      |          | Perform a Whois lookup for the target domain.       |
| `--crawl`      |          | Crawl the target website.                           |
| `--dns`        |          | Perform DNS enumeration on the target domain.       |
| `--sub`        |          | Enumerate subdomains for the target domain.         |
| `--dir`        |          | Search for directories on the target website.       |
| `--wayback`    |          | Retrieve Wayback URLs for the target.               |
| `--ps`         |          | Perform a fast port scan on the target.             |
| `--full`       |          | Perform a full reconnaissance scan on the target.   |
|                |          |                                                     |