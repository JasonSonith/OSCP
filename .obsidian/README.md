# Obsidian Config Backup — Portable Template

**Source vault:** `C:\Users\Jason\Vaults\Jason\.obsidian`
**Captured:** 2026-07-11
**Purpose:** Clean, portable Obsidian configuration template. Drop into a new vault's
`.obsidian/` folder to reproduce appearance, hotkeys, themes, snippets, and plugins.

---

## ⚠️ Credential files were deliberately excluded

This template contains **no secrets**. Anything that held a credential was left behind
on purpose, and **must be reconfigured per-vault** after you restore.

### `plugins/obsidian-local-rest-api/data.json` — NOT COPIED

This file was excluded. It contained:

- `apiKey` — the bearer token used by external tools to reach the vault
- `crypto.privateKey` — an **RSA private key** (the plugin's self-signed HTTPS cert)
- `crypto.cert` / `crypto.publicKey` — the matching certificate and public key
- `port` / `insecurePort` — machine-local port bindings

**To restore:** install the Local REST API plugin in the new vault, open its settings,
and let it generate a fresh API key and certificate. Then paste the new API key into
whatever client consumes it. Do **not** copy the old key across — it is bound to the
old vault and, having lived on disk, should be treated as rotate-on-sight.

### Every other plugin `data.json` was swept and cleared

| File | Verdict |
|---|---|
| `plugins/obsidian-git/data.json` | No credentials. Copied. |
| `plugins/pocket-bird/data.json` | No credentials. Copied. |

The sweep looked for fields named `apiKey`, `token`, `secret`, `password`, and for
long random-looking strings. It also scanned every copied file for PEM key blocks;
the only `-----BEGIN` matches were PGP-signature *parsing code* inside the bundled
isomorphic-git library, not key material.

---

## Vault-specific setting to review

`plugins/obsidian-git/data.json` sets `"basePath": "predictive-maintenance"` — the
subfolder Obsidian Git treats as the repo root. This points at the old vault's layout.
Change or clear it when restoring into a different vault.

---

## Also excluded (machine-specific churn, not secrets)

- `workspace.json` — current pane/layout state
- `workspace-DESKTOP-JN7RUON*.json` and `workspace-Jason*.json` (38 files) — per-machine
  layout snapshots Obsidian accumulates. Same category of churn as `workspace.json`.
- `workspace-mobile.json` — not present in the source
- `cache/` — not present in the source
- `.git/` — **not present inside `.obsidian`.** Nothing to clean up here.

---

## What's included

- `app.json`, `appearance.json`, `core-plugins.json`, `community-plugins.json`,
  `hotkeys.json`, `graph.json`
- `themes/` — 14 themes
- `snippets/` — 5 CSS snippets
- `plugins/` — obsidian-git, obsidian-local-rest-api (minus its `data.json`), pocket-bird

## Restoring

1. Copy the contents of this folder into the new vault's `.obsidian/` directory.
2. Open the vault in Obsidian.
3. Re-enable community plugins if prompted.
4. Regenerate the Local REST API key/cert (see above) and repoint any clients at it.
5. Review Obsidian Git's `basePath` and its remote/credentials.
