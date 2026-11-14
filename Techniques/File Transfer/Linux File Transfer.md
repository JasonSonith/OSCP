---
permalink: oscp/techniques/file-transfer/untitled
title: Untitled
type: note
---
## Download Operations

#### Checking File Hash
```bash
md5sum id_rsa
```


#### Encoding SSH Keys
```bash
cat id_rsa |base64 -w 0;echo
```

#### Decoding a file
```bash
echo -n '<INSERT BASE64 PAYLOAD>' | base64 
```
