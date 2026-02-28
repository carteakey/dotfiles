# Bitwarden CLI Helper

Help me with Bitwarden CLI (`bw`) operations. Common tasks:

## Session management
```bash
bw login                                # first time login
export BW_SESSION=$(bw unlock --raw)    # unlock + set session
bw lock                                 # lock when done
bw status                               # check status
bw sync                                 # pull latest from server
```

## Import SSH keys (+ secure note backup)
Given a private key file and its .pub, import as SSH Key item (type=5) for the
Bitwarden SSH agent AND as a Secure Note backup. Pattern used:

```bash
export BW_SESSION=$(bw unlock --raw)

# 1. Generate fingerprint
FP=$(ssh-keygen -l -f /path/to/key.pub | awk '{print $2}')

# 2. SSH Key item (picked up by Bitwarden SSH agent automatically)
PRIV=$(cat /path/to/key)
PUB=$(cat /path/to/key.pub)
ENCODED=$(bw get template item \
  | jq --arg n "server-name" --arg priv "$PRIV" --arg pub "$PUB" --arg fp "$FP" \
    '.type=5 | .name=$n | .sshKey={"privateKey":$priv,"publicKey":$pub,"keyFingerprint":$fp}' \
  | bw encode)
bw create item "$ENCODED"

# 3. Secure Note backup
CONTENT="=== PRIVATE KEY ===
$(cat /path/to/key)

=== PUBLIC KEY ===
$(cat /path/to/key.pub)"
ENCODED=$(bw get template item \
  | jq --arg n "server-name (backup)" --arg notes "$CONTENT" \
    '.type=2 | .name=$n | .secureNote.type=0 | .notes=$notes' \
  | bw encode)
bw create item "$ENCODED"

# 4. Delete key files once confirmed in vault
rm /path/to/key /path/to/key.pub

bw lock
```

Key notes:
- `bw create item` takes encodedJson as a **positional arg**, not stdin
- Fingerprint is required for type=5 SSH Key items
- Bitwarden Desktop SSH agent must be running to serve keys automatically
- No `IdentityFile` needed in `~/.ssh/config` when using the agent

## Secure notes (recovery keys, tokens, secrets)
```bash
ENCODED=$(bw get template item \
  | jq --arg n "My Secret" --arg notes "content here" \
    '.type=2 | .name=$n | .secureNote.type=0 | .notes=$notes' \
  | bw encode)
bw create item "$ENCODED"
```

## Search & retrieve
```bash
bw list items --search <term>
bw get password <name>
bw get username <name>
bw get item <name>
```

## Import passwords from CSV
```bash
bw import chromecsv ~/path/to/chrome-export.csv
# Chrome Passwords 2.csv is usually the superset — check with diff/sort first
```

## Export vault
```bash
bw export --format json --output ~/bw-backup.json
bw export --format encrypted_json --output ~/bw-backup-enc.json
```

Based on what I need, suggest the right `bw` commands and handle encoding/jq pipelines.
