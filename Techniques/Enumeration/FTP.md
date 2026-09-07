---
title: Untitled
type: note
permalink: oscp/techniques/enumeration/untitled-2
---

## FTP basics
- FTP is a server that allows for file transfer over a network
- Client sends commands to the server and server returns status codes

### Active vs Passive FTP
- In active, the client establishes a connection via TCP port 21 and informs the server which client port it can transmit it's responses over
	- If firewall protects the client, the server cannot reply
- Passive mode developed to counteract firewall, server announces a port through which the client can establish the data channel

## TFTP - Trivial File Transfer Protocol
- Simpler than FTP
- Does not provide user auth 
- TFTP uses UDP

#### Commands
|**Commands**|**Description**|
|---|---|
|`connect`|Sets the remote host, and optionally the port, for file transfers.|
|`get`|Transfers a file or set of files from the remote host to the local host.|
|`put`|Transfers a file or set of files from the local host onto the remote host.|
|`quit`|Exits tftp.|
|`status`|Shows the current status of tftp, including the current transfer mode (ascii or binary), connection status, time-out value, and so on.|
|`verbose`|Turns verbose mode, which displays additional information during file transfer, on or off.|
## Default Configuration
- Most used FTP server on linux is *vsFTPd*
	- Config file from in `/etc/vsftpd.conf`

#### Config File
|**Setting**|**Description**|
|---|---|
|`listen=NO`|Run from inetd or as a standalone daemon?|
|`listen_ipv6=YES`|Listen on IPv6 ?|
|`anonymous_enable=NO`|Enable Anonymous access?|
|`local_enable=YES`|Allow local users to login?|
|`dirmessage_enable=YES`|Display active directory messages when users go into certain directories?|
|`use_localtime=YES`|Use local time?|
|`xferlog_enable=YES`|Activate logging of uploads/downloads?|
|`connect_from_port_20=YES`|Connect from port 20?|
|`secure_chroot_dir=/var/run/vsftpd/empty`|Name of an empty directory|
|`pam_service_name=vsftpd`|This string is the name of the PAM service vsftpd will use.|
|`rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem`|The last three options specify the location of the RSA certificate to use for SSL encrypted connections.|
|`rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key`||
|`ssl_enable=NO`||
- `/etc/ftpusers` can deny or allow certain users from using FTP

## Dangerous Settings
- One of the dangerous settings is allowing `anonymous` users to login
- can be added to vsFTPd as a optional setting:

|**Setting**|**Description**|
|---|---|
|`anonymous_enable=YES`|Allowing anonymous login?|
|`anon_upload_enable=YES`|Allowing anonymous to upload files?|
|`anon_mkdir_write_enable=YES`|Allowing anonymous to create new directories?|
|`no_anon_password=YES`|Do not ask anonymous for password?|
|`anon_root=/home/username/ftp`|Directory for anonymous.|
|`write_enable=YES`|Allow the usage of FTP commands: STOR, DELE, RNFR, RNTO, MKD, RMD, APPE, and SITE?|
#### `status` command
![[Pasted image 20260907011803.png]]
- Gives us overview of server settings

#### `debug` and `trace` command for more information
![[Pasted image 20260907011854.png]]

## More FTP settings
|**Setting**|**Description**|
|---|---|
|`dirmessage_enable=YES`|Show a message when they first enter a new directory?|
|`chown_uploads=YES`|Change ownership of anonymously uploaded files?|
|`chown_username=username`|User who is given ownership of anonymously uploaded files.|
|`local_enable=YES`|Enable local users to login?|
|`chroot_local_user=YES`|Place local users into their home directory?|
|`chroot_list_enable=YES`|Use a list of local users that will be placed in their home directory?|

|**Setting**|**Description**|
|---|---|
|`hide_ids=YES`|All user and group information in directory listings will be displayed as "ftp".|
|`ls_recurse_enable=YES`|Allows the use of recurse listings.|

## Hiding IDs
- The following example shows that `hide_ids=YES` can be used to make identifying file ownership harder
![[Pasted image 20260907012041.png]]
- `ls -R` for recursive listing
- `tree .` can do the same

## Download all files
![[Pasted image 20260907012137.png]]
- `touch {file}` can be used to 