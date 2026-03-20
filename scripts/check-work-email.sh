#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: gh CLI is required." >&2
  exit 1
fi

OWNER="${1:-$(gh api user --jq .login)}"
OLD_EMAIL="${2:-kartikey_chauhan+mcafee@mcafee.com}"
DOMAIN="${3:-mcafee.com}"

TMP="$(mktemp)"
TMP_FILTERED="$(mktemp)"

cleanup() {
  rm -f "$TMP" "$TMP_FILTERED"
}
trap cleanup EXIT

run_gh() {
  NO_COLOR=1 CLICOLOR=0 GH_PAGER=cat GH_FORCE_TTY=0 gh "$@"
}

# Exact old-email matches.
run_gh search commits --owner "$OWNER" --author-email "$OLD_EMAIL" --limit 1000 \
  --json repository,sha,url,commit \
  --jq '.[] | [.repository.fullName, .sha, .url, .commit.author.email, .commit.committer.email] | @tsv' \
  >>"$TMP" || true

run_gh search commits --owner "$OWNER" --committer-email "$OLD_EMAIL" --limit 1000 \
  --json repository,sha,url,commit \
  --jq '.[] | [.repository.fullName, .sha, .url, .commit.author.email, .commit.committer.email] | @tsv' \
  >>"$TMP" || true

# Broader domain scan, then filter strictly by author/committer emails.
run_gh search commits "$DOMAIN" --owner "$OWNER" --limit 1000 \
  --json repository,sha,url,commit \
  --jq '.[] | [.repository.fullName, .sha, .url, (.commit.author.email // ""), (.commit.committer.email // "")] | @tsv' \
  >>"$TMP" || true

if [ ! -s "$TMP" ]; then
  echo "No matching commits found for owner '$OWNER'."
  exit 0
fi

sort -u "$TMP" | awk -F '\t' -v old="$OLD_EMAIL" -v dom="$DOMAIN" '
  tolower($4) == tolower(old) ||
  tolower($5) == tolower(old) ||
  index(tolower($4), "@" tolower(dom)) > 0 ||
  index(tolower($5), "@" tolower(dom)) > 0
' >"$TMP_FILTERED"

if [ ! -s "$TMP_FILTERED" ]; then
  echo "No matching commits found for owner '$OWNER'."
  exit 0
fi

echo "Repos with matching emails:"
cut -f1 "$TMP_FILTERED" | sort -u
echo ""
echo "Counts by repo:"
cut -f1 "$TMP_FILTERED" | sort | uniq -c | sort -nr
echo ""
echo "Commit hits (repo sha url author_email committer_email):"
cat "$TMP_FILTERED"
