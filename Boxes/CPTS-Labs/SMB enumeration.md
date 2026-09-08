## Steps

### 1) Run Nmap scan to see what was open
```bash
nmap -Pn -sCV -p 136,137,138,139,445 $ip
```
- Found SMB was open
- Found version was `Samba smbd 4`

### 2) 