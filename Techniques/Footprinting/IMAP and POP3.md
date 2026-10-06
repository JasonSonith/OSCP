---
title: Untitled
type: note
permalink: oscp/techniques/footprinting/untitled-1
---

## What it is
- *IMAP* (Internet Message Access Protocol) is for online management of emails on a remote server
- *POP3* grabs the main and puts a local copy on your device
- Both are accessed via port `143` but can use an alternate port `993`
- IMAP sends stuff unencrypted and in plaintext

## Default Configuration
- `dovecot-imapd` and `dovecot-pop3d` using `apt` are used to install IMAP/POP3 

#### IMAP commands

|**Command**|**Description**|
|---|---|
|`1 LOGIN username password`|User's login.|
|`1 LIST "" *`|Lists all directories.|
|`1 CREATE "INBOX"`|Creates a mailbox with a specified name.|
|`1 DELETE "INBOX"`|Deletes a mailbox.|
|`1 RENAME "ToRead" "Important"`|Renames a mailbox.|
|`1 LSUB "" *`|Returns a subset of names from the set of names that the User has declared as being `active` or `subscribed`.|
|`1 SELECT INBOX`|Selects a mailbox so that messages in the mailbox can be accessed.|
|`1 UNSELECT INBOX`|Exits the selected mailbox.|
|`1 FETCH <ID> all`|Retrieves data associated with a message in the mailbox.|
|`1 CLOSE`|Removes all messages with the `Deleted` flag set.|
|`1 LOGOUT`|Closes the connection with the IMAP server.|

#### POP3 Commands

