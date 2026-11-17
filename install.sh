#!/bin/sh
# Symlink the repo files into place; an existing file is kept as .bak.
set -eu

repo=$(cd "$(dirname "$0")" && pwd)

link() {
    src="$repo/$1" dst="$2"
    if [ "$(readlink "$dst" 2>/dev/null)" = "$src" ]; then
        return
    fi
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mv "$dst" "$dst.bak"
        echo "backup: $dst.bak"
    fi
    ln -s "$src" "$dst"
    echo "link: $dst → $src"
}

link tmux.conf "$HOME/.tmux.conf"
for f in tmux-project tmux-notify tmux-notify-monitor; do
    link "bin/$f" "$HOME/.local/bin/$f"
done
link systemd/tmux-notify-monitor.service "$HOME/.config/systemd/user/tmux-notify-monitor.service"

if command -v systemctl >/dev/null; then
    systemctl --user daemon-reload 2>/dev/null || true
fi
