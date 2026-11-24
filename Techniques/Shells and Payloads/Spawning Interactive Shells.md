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


