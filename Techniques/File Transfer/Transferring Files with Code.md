
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

#### Using `File_get_contents()` method
```bash
php -r '$file = file_get_contents("<URL TO FILE>"); file_put_contents(")'
```