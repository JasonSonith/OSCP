---
permalink: oscp/techniques/enumeration/web-info-gather/untitled-1
title: Untitled
type: note
---

## Breadth-First Crawling
![[Pasted image 20261028151946.png]]
- Prioritizes *width over depth* when exploring a website
- Useful for broad overview

---

## Depth First Crawling
![[Pasted image 20261028152045.png]]
- Prioritizes *depth over width* by following a single path of links as far as possible

---

## Extracting Information
- External and Internal *links*
- *Comment sections* on blogs, forums, etc to reveal sensitive information
- *Metadata* providing context of page content and purpose
- *Sensitive Files:* Web crawling searches for sensitive files such as backup files (`.bak`, `.old`, etc), config files, log files, and api keys

---
## ReconSpider for web crawling
```json 
{
    "emails": [
        "lily.floid@inlanefreight.com",
        "cvs@inlanefreight.com",
        ...
    ],
    "links": [
        "https://www.themeansar.com",
        "https://www.inlanefreight.com/index.php/offices/",
        ...
    ],
    "external_files": [
        "https://www.inlanefreight.com/wp-content/uploads/2020/09/goals.pdf",
        ...
    ],
    "js_files": [
        "https://www.inlanefreight.com/wp-includes/js/jquery/jquery-migrate.min.js?ver=3.3.2",
        ...
    ],
    "form_fields": [],
    "images": [
        "https://www.inlanefreight.com/wp-content/uploads/2021/03/AboutUs_01-1024x810.png",
        ...
    ],
    "videos": [],
    "audio": [],
    "comments": [
        "<!-- #masthead -->",
        ...
    ]
}
```
- Data from `reconspider` always gets sav
