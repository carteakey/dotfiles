# ~/.zshrc

# ── Docker ────────────────────────────────────────────────────────────────────
alias dcu='docker compose --env-file .env up -d'
alias dcd='docker compose down'
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
alias dc-rebuild='docker compose up -V --remove-orphans --force-recreate'
alias docker-clean='docker system prune -a --volumes --force'

# ── Git ───────────────────────────────────────────────────────────────────────
alias git-url='git config --get remote.origin.url'

# ── Brew ──────────────────────────────────────────────────────────────────────
alias brew-tree='brew deps --tree --installed'

# ── Network ───────────────────────────────────────────────────────────────────
alias ports='lsof -i -P -n | grep LISTEN'

# ── SSH / Homelab ─────────────────────────────────────────────────────────────
alias kpc='ssh kpc-ts -t "zellij attach --create main"'

# ── Bitwarden SSH Agent (Mac App Store) ───────────────────────────────────────
export SSH_AUTH_SOCK=~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock

# ── Ollama ────────────────────────────────────────────────────────────────────
export OLLAMA_ORIGINS='chrome-extension://*'

# ── NVM ───────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ── PATH ──────────────────────────────────────────────────────────────────────
export PATH="/Users/kchauhan/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/Users/kchauhan/.antigravity/antigravity/bin:$PATH"

# ── Machine-local overrides (conda, etc.) ────────────────────────────────────
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
