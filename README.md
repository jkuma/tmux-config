# tmux-config

Configuration tmux pensée pour le développement au quotidien avec [Claude Code](https://claude.com/claude-code) : leader `Ctrl+Space`, popups fzf pour naviguer entre projets et sessions, barre de statut Solarized Dark, notifications du bureau dans la barre.

## Installation

```sh
git clone https://github.com/jkuma/tmux-config.git ~/Projects/tmux-config
~/Projects/tmux-config/install.sh
```

`install.sh` crée des liens symboliques vers le dépôt (un fichier déjà présent est conservé en `.bak`) :

| Lien | Cible |
|---|---|
| `~/.tmux.conf` | `tmux.conf` |
| `~/.local/bin/tmux-project`, `tmux-notify`, `tmux-notify-monitor` | `bin/` |
| `~/.config/systemd/user/tmux-notify-monitor.service` | `systemd/` |

Les modifications faites dans `~/.tmux.conf` (ou via `prefix + e`) atterrissent donc directement dans le dépôt.

### Réglages propres à la machine

`~/.tmux.local.conf` est chargé à la fin de la configuration, s'il existe. Exemple :

```tmux
set -g default-shell "/usr/bin/zsh"
set -g @project-dirs "$HOME/Documents/Code $HOME/Projects"
```

## Prérequis

- tmux ≥ 3.8, Linux
- [fzf](https://github.com/junegunn/fzf) et git pour les popups `prefix + f` et `prefix + C-f`
- Optionnels : [tig](https://jonas.github.io/tig/) (popup git), btop, `wl-copy` ou `xclip` (presse-papier), [TPM](https://github.com/tmux-plugins/tpm) (resurrect / continuum)
- Notifications : bureau Linux avec D-Bus (GNOME…), `python3-gi`, gawk

## Raccourcis

Le leader est `Ctrl+Space` (noté `prefix`).

| Raccourci | Action |
|---|---|
| `prefix + f` | Choisir un dépôt git ou un worktree (sous `@project-dirs`) : rejoint la fenêtre ouverte dessus, sinon en crée une |
| `prefix + C-f` | Basculer vers une autre session |
| `prefix + g` | Git en popup (tig, sinon historique) |
| `prefix + a` / `A` | Lancer Claude dans une nouvelle fenêtre / un split |
| `prefix + C-a` | Session Claude flottante et persistante (bascule) |
| `Alt+g` | Terminal flottant persistant (bascule) |
| `prefix + u` | Lister les URLs visibles dans le pane |
| `prefix + C-n` / `M-n` | Afficher / marquer comme lues les notifications |
| `Alt+b` | Aller à la prochaine fenêtre signalée (sonnerie ou `●`) |
| `Alt+h/j/k/l` | Changer de pane |
| `Shift+←/→` | Fenêtre précédente / suivante |
| `prefix + \|` / `-` | Split vertical / horizontal dans le dossier courant |
| `Alt+↑` | Mode copie (vi), avec barre de défilement |
| `F12` | Couper les raccourcis locaux pour piloter un tmux distant (SSH) |
| `prefix + r` / `e` | Recharger / éditer la configuration |

## Barre de statut

- `●` après le nom d'une fenêtre : du nouveau s'y est affiché depuis la dernière visite.
- `⛶` : un pane de la fenêtre est zoomé.
- Pastille jaune : la fenêtre a sonné (Claude a fini ou attend une réponse).
- À droite : notifications non lues, branche git, dossier courant, heure.
- Les popups et menus reprennent les couleurs ANSI du terminal ; la palette de la barre se change en tête de `tmux.conf` (et dans `bin/tmux-notify`, qui en garde une copie).

## Notifications du bureau

`tmux-notify-monitor` écoute les notifications D-Bus et les empile dans une file ; le compteur s'affiche dans la barre. Pour l'activer :

```sh
systemctl --user enable --now tmux-notify-monitor
```

Les applications à ignorer se listent, une par ligne, dans `~/.config/tmux-notify/ignore`.

## Licence

[MIT](LICENSE)
