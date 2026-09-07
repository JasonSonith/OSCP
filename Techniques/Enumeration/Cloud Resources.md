---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-1
---

## Google search using `intext` and `inurl`
- `intext` searches contents of webpage for text
- `inurl` searches contents of url for text
- This is called *Google Dorking*
#### Example
```
intext:"confidential"inurl:secret
```

#### Google Dorking Cheatsheet

## *Domain.glass* 
- Can tell us about company infrastructure
- Below, the HTB website was listed as safe which was a security measure to the 2nd layer: *gateway*
![[Pasted image 20260906235545.png]]

## GreyHatWarfare
- Can discover AWS, Azure, and GCP cloud storage and filter them by file format

#### HTB example results
![[Pasted image 20260906235640.png]]

#### Sea