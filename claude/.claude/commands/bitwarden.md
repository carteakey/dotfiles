# Bitwarden CLI Helper

Help me with Bitwarden CLI (`bw`) operations. Common tasks:

## Session management
```bash
bw login                          # first time login
export BW_SESSION=$(bw unlock --raw)   # unlock + set session
bw lock                           # lock when done
bw status                         # check status
```

## SSH keys
Store SSH keys in vault (type=5), retrieve and add to agent:
```bash
# Add key to vault
bw get template item | jq '.type=5 | .name="<keyname>" | .sshKey.privateKey="<paste key>"' | bw encode | bw create item

# Use key
bw get item "<keyname>" | jq -r '.sshKey.privateKey' | ssh-add -
```

## Search & retrieve
```bash
bw list items --search <term>
bw get password <name>
bw get username <name>
bw get item <name>
```

## Import / Export
```bash
bw import chromecsv ~/path/to/chrome-export.csv
bw export --format json --output ~/bw-backup.json
```

## Secure notes (for recovery keys, tokens etc.)
```bash
bw get template item | jq '.type=2 | .secureNote.type=0 | .name="<name>" | .notes="<content>"' | bw encode | bw create item
```

Based on what I need, suggest the right `bw` commands and handle encoding/jq pipelines.
