Convert the specified Obsidian note into a carteakey.dev blog post. If no note path is given, use the note currently being discussed.

## Steps

### 1. Read the note
Read the Obsidian markdown file. Identify:
- All `![[Pasted image *.png]]` references
- The note's title, topic, and rough date

### 2. Find images
Images live in `/home/kchauhan/repos/vault-76/1. system 📊/attachments/`.
Match each `![[Pasted image YYYYMMDDHHMMSS.png]]` to its file there.

### 3. Derive a slug and date
- Date: from the filename timestamps or note content (format: `YYYY-MM-DD`)
- Slug: lowercase, hyphenated, descriptive (e.g. `cost-effective-coding-agents`)
- Blog post filename: `YYYY-MM-DD-slug.md`

### 4. Name and copy images
Give each image a clean, descriptive name tied to the post slug:
`{slug}-{description}.png` (e.g. `coding-agents-amp.png`)

Copy from vault attachments to `/home/kchauhan/repos/carteakey.dev/src/static/img/`:
```
cp "/home/kchauhan/repos/vault-76/1. system 📊/attachments/Pasted image XXXXXX.png" \
   /home/kchauhan/repos/carteakey.dev/src/static/img/{slug}-{description}.png
```

### 5. Convert the note to a blog post
Create `/home/kchauhan/repos/carteakey.dev/src/posts/YYYY-MM-DD-slug.md` with:

**Frontmatter** (follow the template at `src/posts/1990-01-01-template.md`):
```yaml
---
title: <title>
description: <one sentence summary>
date: YYYY-MM-DD
tags:
  - <tag1>
  - <tag2>
hidden: false
pinned: false
featured: false
---
```

**Content conversions:**
- Replace all `![[Pasted image *.png]]` with the Eleventy image shortcode:
  - No caption: `{% image "./src/static/img/{slug}-{description}.png", "descriptive alt text" %}`
  - With caption: `{% image_cc "./src/static/img/{slug}-{description}.png", "Title", "", "Caption text." %}`
  - Use `image_cc` when the image benefits from a label (e.g. screenshots of tools, UI comparisons)
- Convert Obsidian internal links `[[note name]]` to plain text or omit
- Strip Obsidian-specific syntax (dataview blocks, callout `> [!note]` if not supported)
- Keep all writing style, voice, and tone exactly as-is — do not paraphrase or clean up
- Use exactly 2 tags. Keep acronyms uppercase (e.g. `AI`, `LLM`, `ETL`). Capitalise all tags title-case (e.g. `Agents`, `Coding`, `Productivity`). Check existing posts for the canonical casing of a tag before using it — mismatched casing creates duplicate tag pages and breaks the build.

### 6. Copy the vault note to published
After the blog post is created, copy the note to the published folder:
```
cp "<vault-note-path>" "/home/kchauhan/repos/vault-76/3. projects 🚀/carteakey.dev/blog/Published/<note-name>.md"
```

### 7. Confirm and publish
Report the blog post path, images copied, and vault note destination, then ask the user for approval to publish.

On approval:
1. Run a build to verify success:
   ```
   cd /home/kchauhan/repos/carteakey.dev && npm run build
   ```
2. Only if the build succeeds, commit and push:
   ```
   cd /home/kchauhan/repos/carteakey.dev
   git add .
   git commit -m "Add post: <title>"
   git push
   ```
3. Report the result (build output, commit hash, push status).
