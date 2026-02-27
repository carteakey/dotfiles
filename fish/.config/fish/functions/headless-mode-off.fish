function headless-mode-off
    echo "==> Restoring GUI..."
    sudo systemctl isolate graphical.target
    systemctl --user start openclaw-gateway 2>/dev/null
    echo "==> Done. GUI should be back on TTY1 (Ctrl+Alt+F1)."
end
