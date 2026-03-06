#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ── History ───────────────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check window size after each command
shopt -s checkwinsize

# ── Color prompt ──────────────────────────────────────────────────────────────
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# ── Bash completion ───────────────────────────────────────────────────────────
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ── Colors ────────────────────────────────────────────────────────────────────
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

# ── SSH / Homelab ─────────────────────────────────────────────────────────────
alias kpc='ssh kchauhan@100.94.123.10 -t "zellij attach --create main"'

# Default editor
export EDITOR=nvim
export VISUAL=nvim
alias v=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# ── Pi-specific ───────────────────────────────────────────────────────────────
alias brow='docker run --rm -ti fathyb/carbonyl'
alias wifi-5ghz="sudo nmcli connection modify 'Bell Basement_EXT' 802-11-wireless.band a && sudo nmcli connection up 'Bell Basement_EXT'"
alias wifi-24ghz="sudo nmcli connection modify 'Bell Basement_EXT' 802-11-wireless.band bg && sudo nmcli connection up 'Bell Basement_EXT'"
[ -f ~/scripts/browser.sh ] && source ~/scripts/browser.sh
