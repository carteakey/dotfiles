source /usr/share/cachyos-fish-config/cachyos-config.fish

# ── Docker ────────────────────────────────────────────────────────────────────
abbr -a dcu 'docker compose --env-file .env up -d'
abbr -a dcd 'docker compose down'
abbr -a dc-rebuild 'docker compose up -V --remove-orphans --force-recreate'
abbr -a docker-clean 'docker system prune -a --volumes --force'
function dps
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
end

# ── Git ───────────────────────────────────────────────────────────────────────
abbr -a git-url 'git config --get remote.origin.url'

# ── Network ───────────────────────────────────────────────────────────────────
abbr -a ports 'ss -tulpn | grep LISTEN'

# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim
abbr -a v nvim

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# opencode
fish_add_path /home/kchauhan/.opencode/bin

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

# OpenClaw Completion
source "/home/kchauhan/.openclaw/completions/openclaw.fish"
