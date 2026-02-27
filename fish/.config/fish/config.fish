source /usr/share/cachyos-fish-config/cachyos-config.fish

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
