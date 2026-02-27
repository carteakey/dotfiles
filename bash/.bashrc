#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ── Docker ────────────────────────────────────────────────────────────────────
alias dcu='docker compose --env-file .env up -d'
alias dcd='docker compose down'
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
alias dc-rebuild='docker compose up -V --remove-orphans --force-recreate'
alias docker-clean='docker system prune -a --volumes --force'

# ── Git ───────────────────────────────────────────────────────────────────────
alias git-url='git config --get remote.origin.url'

# ── Network ───────────────────────────────────────────────────────────────────
alias ports='ss -tulpn | grep LISTEN'

# Default editor
export EDITOR=nvim
export VISUAL=nvim
alias v=nvim
PS1='[\u@\h \W]\$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
