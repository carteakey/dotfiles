Convert the specified Obsidian note into a carteakey.dev snippet. If no note path is given, use the note currently being discussed.

Snippets are short, focused technical references — commands, scripts, step-by-step install guides. No images, no longform prose. See existing snippets at `/home/kchauhan/repos/carteakey.dev/src/snippets/` for format reference.

## Steps

### 1. Read the note
Read the Obsidian markdown file. Identify:
- The core topic (e.g. "Enable SSH on CachyOS")
- Any formatting issues: bare language labels before code blocks, inconsistent headings, Obsidian-specific syntax

### 2. Derive slug and filename
- Slug: lowercase, hyphenated (e.g. `enable-ssh-cachyos`)
- Snippet filename: `{slug}.md`

### 3. Write the snippet
Create `/home/kchauhan/repos/carteakey.dev/src/snippets/{slug}.md` with:

**Frontmatter:**
```yaml
---
title: <concise title>
description: <one sentence — what it does and on what system/context>
date: <YYYY-MM-DDT00:00:00.000Z>
updated: <YYYY-MM-DDT00:00:00.000Z>
slug: <slug>
---
```

**Content rules:**
- Fix all code block formatting: bare language labels (`bash`, `python`, etc.) appearing as plain text before fences must be moved into the fence: ` ```bash `
- Use `##` for top-level steps, `###` for sub-steps if needed
- Keep content concise — snippets are reference material, not tutorials
- Preserve all commands exactly as written; do not paraphrase technical content
- Convert Obsidian-specific syntax (callouts, wikilinks) to standard markdown or plain text
- No images in snippets

### 4. Move the vault note
After the snippet is created, move and rename the vault note to the homelab snippets folder:
```
mv "<vault-note-path>" "/home/kchauhan/repos/vault-76/3. projects 🚀/homelab/snippets/<Descriptive Title>.md"
```

### 5. Confirm
Report:
- Snippet path created
- Where the vault note was moved to
