---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1-1-1
tags:
- template
---

# Validate File Trasfer

## What it is
- Using `file` in linux to validate file format

## How to test

#### Example
```bash
file shell

#output
shell: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, no section header
```
- This says the shell is a ELF binary (meaning we successfully transferred it)

#### Check MD5 hash to ensure file transfer was successful
```bash
md5sum shell

#output
321de1d7e7c3735838890a72c9ae7d1d shell

# Go to remote server and run the same command
md5sum shell

#output
321de1d7e7c3735838890a72c9ae7d1d shell
```

- If they match then it's a success and files transferred correctly