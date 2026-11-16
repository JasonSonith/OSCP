---
permalink: oscp/techniques/file-transfer/untitled-4
title: Untitled
type: note
---
## File Encryption on Windows

### Invoke-AesEncryption.ps1 powershell script

#### Encrypting text
```powershell
Invoke-AESEncryption -Mode Encrypt -Key "<STRING>" -Text "<SECRET TEXT>"
```

#### Decrypting text
```powershell
Invoke-AESEncryption -Mode Decrypt -Key "<STRING>" -Text "<CIPHERTEXT>"
```

#### Encry