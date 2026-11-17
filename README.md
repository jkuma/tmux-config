# tmux-config

A tmux configuration built for day-to-day development with [Claude Code](https://claude.com/claude-code): `Ctrl+Space` leader, fzf popups to jump between projects and sessions, a Solarized Dark status bar, and desktop notifications in the bar.

## Installation

```sh
git clone https://github.com/jkuma/tmux-config.git ~/Projects/tmux-config
~/Projects/tmux-config/install.sh
```

`install.sh` symlinks the repo files into place (an existing file is kept as `.bak`):

| Link | Target |
|---|---|
| `~/.tmux.conf` | `tmux.conf` |
| `~/.local/bin/tmux-project`, `tmux-notify`, `tmux-notify-monitor` | `bin/` |
| `~/.config/systemd/user/tmux-notify-monitor.service` | `systemd/` |

Changes made to `~/.tmux.conf` (or via `prefix + e`) therefore land directly in the repo.

### Machine-specific settings

`~/.tmux.local.conf` is loaded at the end of the configuration, if it exists. Example:

```tmux
set -g default-shell "/usr/bin/zsh"
set -g @project-dirs "$HOME/Documents/Code $HOME/Projects"
set -g @project-depth 3   # repos up to 3 levels below each directory
```

## Requirements

- tmux ≥ 3.8, Linux
- [fzf](https://github.com/junegunn/fzf) and git for the `prefix + f` and `prefix + C-f` popups
- Optional: [tig](https://jonas.github.io/tig/) (git popup), btop, `wl-copy` or `xclip` (clipboard), [TPM](https://github.com/tmux-plugins/tpm) (resurrect / continuum)
- Notifications: a Linux desktop with D-Bus (GNOME…), `python3-gi`, gawk

## Key bindings

The leader is `Ctrl+Space` (written `prefix`).

| Binding | Action |
|---|---|
| `prefix + f` | Pick a git repo or worktree (under `@project-dirs`): switch to the window open on it, or create one |
| `prefix + C-f` | Switch to another session |
| `prefix + g` | Git in a popup (tig, else the log) |
| `prefix + a` / `A` | Start Claude in a new window / a split |
| `prefix + C-a` | Floating, persistent Claude session (toggle) |
| `Alt+g` | Floating, persistent scratch terminal (toggle) |
| `prefix + u` | List the URLs visible in the pane |
| `prefix + C-n` / `M-n` | Show / mark as read the notifications |
| `Alt+b` | Jump to the next flagged window (bell or `●`) |
| `Alt+h/j/k/l` | Move between panes |
| `Shift+←/→` | Previous / next window |
| `prefix + \|` / `-` | Vertical / horizontal split in the current directory |
| `Alt+↑` | Copy mode (vi), with a scrollbar |
| `F12` | Disable local bindings to drive a remote tmux (SSH) |
| `prefix + r` / `e` | Reload / edit the configuration |

## Status bar

- `●` after a window name: new output since your last visit.
- `⛶`: a pane in the window is zoomed.
- Yellow badge: the window rang the bell (Claude is done or waiting for input).
- On the right: unread notifications, git branch, current directory, time.
- Popups and menus use the terminal's ANSI colours; the bar palette is set at the top of `tmux.conf` (and in `bin/tmux-notify`, which keeps a copy).

## Desktop notifications

`tmux-notify-monitor` listens to D-Bus notifications and queues them; the counter shows up in the bar. To enable it:

```sh
systemctl --user enable --now tmux-notify-monitor
```

Applications to ignore are listed, one per line, in `~/.config/tmux-notify/ignore`.

## License

[MIT](LICENSE)
