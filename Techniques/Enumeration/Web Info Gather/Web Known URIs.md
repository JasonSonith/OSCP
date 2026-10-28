---
permalink: oscp/techniques/enumeration/web-info-gather/untitled-2
title: Untitled
type: note
---
## Overview
- `.well-known` is a location in a website where applications and security tools can find important information about the website
- Example: `https://example.com/.well-known/`

### Common Examples
|Path|Purpose|
|---|---|
|`/.well-known/security.txt`|Tells security researchers how to report vulnerabilities|
|`/.well-known/openid-configuration`|Provides authentication configuration|
|`/.well-known/assetlinks.json`|Verifies relationships between Android apps and websites|
|`/.well-known/acme-challenge/`|Helps verify domain ownership for SSL/TLS certificates|
- Request the known path through `curl` could be a good open:
	- `curl https://example.com/.well-known/security.txt`
	- `curl https://example.com/.well-known/openid-configuration`

---
## Web Recon and `.well-known`
	