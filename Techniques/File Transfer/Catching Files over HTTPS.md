---
permalink: oscp/techniques/file-transfer/untitled-3
title: Untitled
type: note
---

## Nginx - Enabling PUT

#### 1) Make the Directory for Uploaded Files
```bash
sudo mkdir -p /var/www/uploads/<FOLDER>
```

#### 2) Change the owner to `www-data`
```bash
sudo chown -R www-data:www-data /var/www/uploads/<FOLDER>
```

#### 3) Create config file
```bash
server {
    listen <PORT>;
    
    location <FOLDER> {
        root    /var/www/uploads;
        dav_methods PUT;
    }
}
```
- Usually created in `/etc/nginx/sites-available/upload.conf`

#### 4) Symlink site to sites-enabled directory
```bash
sudo ln -s /etc/nginx/sites-available/upload.conf /etc/nginx/sites-enabled/
```

#### 5) Start Nginx
```bash
sudo systemctl restart nginx.service
```

#### 6) Verifying Errors
```bash
tail -2 /var/log/nginx/error.log
```
