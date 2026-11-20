# macOS setup for Development

My whole development environment, regrouped so a brand-new (or lost) Mac can be
rebuilt from this repo + a bit of 1Password.

**Don't run everything blindly.** A lot of commands or packages may not suit
you. Fork and review before running anything.

*Last full sync with the live machine: November 2026 (macOS 26 Tahoe).*

## What's covered

| Area | Where |
|---|---|
| Homebrew formulae (k8s/gitops, git, dev tools) | `scripts/brew.sh` |
| Apps, fonts, Mac App Store | `scripts/apps.sh` |
| macOS interface defaults | `scripts/macos.sh` |
| mise (node/ruby), npm globals, keychain checklist | `scripts/tools.sh` |
| Git config & GPG agent | `scripts/git.sh`, `gitfiles/` |
| SSH key generation | `scripts/ssh.sh` |
| Zsh, oh-my-zsh plugins, tmux (+plugins), vim | `scripts/terminal.sh`, `.zshrc`, `.p10k.zsh`, `.vimrc`, `dotfiles/`, `tmux/` |
| Zed (settings, keymap, tasks, extensions) | `scripts/zed.sh`, `zed/` |
| iTerm2 profile & colors | `iterm/` |
| Sublime Text settings (legacy) | `sublime/` |

The zsh "custom" files in `dotfiles/` (`aliases.zsh`, `exports.zsh`,
`functions.zsh`, ...) are copied into `~/.oh-my-zsh/custom/` where oh-my-zsh
auto-loads them — that's where the aliases actually live on disk.

## Full installation

```sh
git clone git@github.com:kinoute/macos-setup.git
cd macos-setup
bash install.sh
```

You'll be asked for your admin password upfront. The script runs brew, apps,
macOS defaults, tools, git, ssh, terminal and zed in order.

## Things the scripts can't do for you

These need 1Password / your accounts, finish them by hand after `install.sh`:

1. **Keychain entries** — read at shell startup by `dotfiles/exports.zsh` and
   `.zshrc`:
   ```sh
   security add-generic-password -U -s gemini-api-key   -a kinoute -w <value>
   security add-generic-password -U -s crowpus-api-key  -a kinoute -w <value>
   security add-generic-password -U -s youtrack-mcp     -a kinoute -w <value>
   security add-generic-password -U -s outline-mcp      -a kinoute -w <value>
   ```
2. **SSH private keys & `~/.ssh/config`** — recover from 1Password, then
   `ssh-add --apple-use-keychain ~/.ssh/id_*`.
3. **Kube contexts** — `~/.kube/config` comes from the kubeseal/cert-manager
   flow per cluster; `switcher` keeps context configs in `~/Documents/Infra/Kubeseal/`.
4. **AWS** — `~/.aws/*` from 1Password (`scw`/`s5cmd` CLIs expect credentials).
5. **Manual app installs**: 1Password, Microsoft Office, GPG Keychain, Crowpus Desktop.
6. **Corporate MDM** (JamfProtect, Stormshield, Self Service SAHAR): enroll as
   usual — deliberately not scripted here.
7. **Zed channel**: the live machine runs preview/dev builds. `scripts/zed.sh`
   restores stable + config + extensions; dev build goes through the normal
   Zed update channels / `~/Sites/zed` checkout if you want it.

## Keeping this repo current

After any meaningful change on the machine:

```sh
# shell stuff
cp ~/.zshrc . && cp ~/.p10k.zsh . && cp ~/.vimrc .
rsync -a --delete --exclude 'Color Highlight.cache' \
  "$HOME/Library/Application Support/Sublime Text/Packages/User/" sublime/
# oh-my-zsh custom files
cp ~/.oh-my-zsh/custom/{aliases,exports,functions,private,ssh_tab_colors}.zsh dotfiles/
cp ~/.oh-my-zsh/custom/plugins/switch/switcher.zsh dotfiles/
# zed
cp ~/.config/zed/{settings,keymap,tasks}.json zed/
# iterm
cp ~/Library/Preferences/com.googlecode.iterm2.plist iterm/
# brew drift
brew leaves        # compare against scripts/brew.sh
mas list           # compare against scripts/apps.sh
mise ls            # compare against scripts/tools.sh
```

Then commit. Secrets never go in this repo: tokens live in the login keychain
and are referenced with `security find-generic-password`.
