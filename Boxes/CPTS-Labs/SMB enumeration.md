## Steps

### 1) Run Nmap scan to see what was open
```bash
nmap -Pn -sCV -p 136,137,138,139,445 $ip
```
- Found SMB was open
- Found version was `Samba smbd 4`

### 2) Listed shares available to me
```bash
smbclient -N -L //10.129.163.243
```
- Found `sambashare was availible`
- Dig into the directory to get the flag.txt

### 3) Used `enum4linux-ng.py` to enumerate the smbshare
```bash
python3 /opt/enum4linux-ng/enum4linux-ng.py $ip -A
```
- Found the domain that belongs to `DEVOPS`
- Found a comment for the samba share that said *"InFreight SMB v3.1"*

### 4) Connected to rpclient to get system directory of `sambashare`
```bash
rpcclient -U ""
```