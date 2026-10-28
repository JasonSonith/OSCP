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
- `openid-configuration` URI is useful because it tells applications how websites handle user authentication

#### `openid-configuration` returns JSON
```json
{
  "issuer": "https://example.com",
  "authorization_endpoint": "https://example.com/oauth2/authorize",
  "token_endpoint": "https://example.com/oauth2/token",
  "userinfo_endpoint": "https://example.com/oauth2/userinfo",
  "jwks_uri": "https://example.com/oauth2/jwks",
  "response_types_supported": ["code", "token", "id_token"],
  "subject_types_supported": ["public"],
  "id_token_signing_alg_values_supported": ["RS256"],
  "scopes_supported": ["openid", "profile", "email"]
}
```

### Understanding the json

|Field|Simple explanation|
|---|---|
|`issuer`|Who creates and issues authentication tokens|
|`authorization_endpoint`|Where users go to authorize an application|
|`token_endpoint`|Where applications request authentication tokens|
|`userinfo_endpoint`|Where applications retrieve information about a logged-in user|
|`jwks_uri`|Where public cryptographic keys are stored to verify tokens|
|`response_types_supported`|Which authentication response types the server supports|
|`scopes_supported`|What information an application can request|
|`id_token_signing_alg_values_supported`|Which algorithms are used to sign identity tokens|

### How authentication works
![[Pasted image 20261028154218.png]]
- User clicks `login`
- Application sends the `authorization endpoint` to sign into
- ``