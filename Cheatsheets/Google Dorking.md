---
title: Untitled
type: note
permalink: oscp/cheatsheets/untitled
---

**Operators (the building blocks)**

|Operator|What it does|Example|
|---|---|---|
|`site:`|Limit results to one domain|`site:example.com`|
|`inurl:`|Word appears in the URL|`inurl:admin`|
|`intitle:`|Word appears in the page title|`intitle:"login"`|
|`intext:`|Word appears in the page body|`intext:password`|
|`filetype:` / `ext:`|Only a given file type|`filetype:pdf`|
|`cache:`|Google's saved copy of a page|`cache:example.com`|
|`related:`|Sites similar to one you give|`related:example.com`|
|`"..."`|Exact phrase match|`"index of /backup"`|
|`-`|Exclude a term|`site:example.com -www`|
|`OR` or `\|`|Match either term|`filetype:sql OR filetype:bak`|
|`*`|Wildcard (any word)|`"password is *"`|
|`..`|Number range|`"revenue 2020..2024"`|
|`AROUND(n)`|Two terms within n words of each other|`admin AROUND(3) password`|
|`allinurl:`|All listed terms must be in the URL|`allinurl:auth login`|

**Pentest dork recipes**

| Goal                  | Dork                                                                | What you're hunting                        |
| --------------------- | ------------------------------------------------------------------- | ------------------------------------------ |
| Map attack surface    | `site:*.example.com -www`                                           | Subdomains and pages beyond the main site  |
| Non-HTML files        | `site:example.com filetype:pdf OR filetype:docx OR filetype:xlsx`   | Documents that may leak internal info      |
| Login pages           | `site:example.com inurl:login OR inurl:signin`                      | Entry points to attack                     |
| Admin panels          | `site:example.com inurl:admin OR intitle:"admin"`                   | Privileged interfaces                      |
| Config / env files    | `site:example.com ext:env OR ext:ini OR ext:conf OR ext:cnf`        | Settings files that often hold secrets     |
| Backups / DB dumps    | `site:example.com ext:sql OR ext:bak OR ext:old OR ext:backup`      | Copied data left on the server             |
| Log files             | `site:example.com ext:log`                                          | Logs that may expose paths, tokens, errors |
| Creds in spreadsheets | `site:example.com filetype:xls intext:password`                     | Passwords stored in plain files            |
| Exposed Git           | `site:example.com inurl:.git`                                       | Source code and history left public        |
| Open directories      | `site:example.com intitle:"index of"`                               | Browsable folders (no access control)      |
| Debug pages           | `site:example.com intitle:"phpinfo()"`                              | Server config disclosure                   |
| SQL error leaks       | `site:example.com intext:"sql syntax near" OR intext:"mysql_fetch"` | Signs of injectable, misconfigured apps    |
| Public S3 buckets     | `site:s3.amazonaws.com example`                                     | Cloud storage exposed to the internet      |
| Paste site leaks      | `site:pastebin.com example.com`                                     | Dumped creds or data mentioning the target |
| Code / secret leaks   | `site:github.com "example.com" password`                            | Secrets committed to public repos          |
| Employee OSINT        | `site:linkedin.com "Example Inc"`                                   | Names for phishing pretext and user lists  |
| Email pattern         | `intext:"@example.com"`                                             | Naming convention (e.g. first.last@)       |