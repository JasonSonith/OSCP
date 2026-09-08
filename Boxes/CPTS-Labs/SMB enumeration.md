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

