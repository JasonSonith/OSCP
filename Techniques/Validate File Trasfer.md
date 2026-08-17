---
title: Technique Template
type: template
permalink: oscp/templates/technique-template-1-1
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

#### Check MD5 hash to ensure 
