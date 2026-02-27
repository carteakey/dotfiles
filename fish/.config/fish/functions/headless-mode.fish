function headless-mode
    echo "==> Entering headless mode..."
    echo ""

    # Switch to multi-user target - this is the proper systemd way.
    # It stops graphical.target and everything that depends on it
    # (sddm, kwin, plasmashell, etc.) without touching TTY sessions.
    echo "  Switching to multi-user.target (stops all GUI services)..."
    sudo systemctl isolate multi-user.target

    # Stop openclaw-gateway (Restart=always so pkill doesn't work)
    echo "  Stopping openclaw-gateway..."
    systemctl --user stop openclaw-gateway 2>/dev/null

    sleep 1

    # Kill any GUI app processes that survived (browsers, electron apps etc.)
    echo "  Killing remaining GUI app processes..."
    for proc in zen firefox firefox-bin chromium brave-browser \
                obsidian code zed-editor zed ghostty konsole kate dolphin \
                discord slack teams qbittorrent transmission spotify \
                plasma-systemmonitor systemsettings
        pkill -x $proc 2>/dev/null && pkill -f $proc 2>/dev/null && echo "    Killed $proc"
    end
    pkill -f "electron" 2>/dev/null && echo "    Killed remaining electron processes"

    # Drop all kernel caches
    echo ""
    echo "  Dropping caches..."
    sudo sync
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
    sudo sh -c 'echo 1 > /proc/sys/vm/compact_memory' 2>/dev/null

    echo ""
    echo "==> Done. Memory:"
    free -h
    echo ""
    echo "  Tip: 'zellij' or 'tmux' for split panes"
    echo "  Restore GUI: headless-mode-off"
end
