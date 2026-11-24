---
permalink: oscp/techniques/shells-and-payloads/untitled-1
title: Untitled
type: note
---

## Initial Shell
```bash
/bin/sh -i
```

---
## Perl
```bash
perl -e 'exec "/bin/sh";'
```

### From a perl script
```perl
exec "/bin/sh";
```

---

## Ruby

#### Ruby To Shell from ruby script
```ruby
exec "/bin/sh"
```

---

## AWK

### awk to shell
```bash
awk 'BEGIN {system("/bin/sh")}'
```

---

## Find 

#### Using Find for A Shell
```bash
find /-name nameoffile -exec /bin/awk /bin/awk 'BEGIN {system("/bin/sh")}' \
```
- It finds the file after `-name` and then it executes the `awk` command

---

## Using Exec to Launch Shell
```bash
find . -exec /bin/sh \; -quit
```

---

## Vim 

#### Vim To Shell
```bash
vim -c ':!/bin/sh'
```

#### Vim in Script
```vim
:set shell=/bin/sh
:shell
```

---

