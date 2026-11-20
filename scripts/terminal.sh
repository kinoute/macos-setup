#!/usr/bin/env bash

###############################################################################
# Zsh, oh-my-zsh plugins, tmux and editor dotfiles                           #
# Run from the repo root                                                     #
###############################################################################

set -uo pipefail
cd "$(dirname "$0")/.."

ZSH_CUSTOM=~/.oh-my-zsh/custom

###############################################################################
# Oh My Zsh                                                                    #
###############################################################################
[ -d ~/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k 2>/dev/null || true

# Plugins
for plugin in \
  "https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions" \
  "https://github.com/zdharma-continuum/fast-syntax-highlighting.git fast-syntax-highlighting" \
  "https://github.com/marlonrichert/zsh-autocomplete zsh-autocomplete" \
  "https://github.com/zsh-users/zsh-completions zsh-completions" \
  "https://github.com/Aloxaf/fzf-tab fzf-tab" \
  "https://github.com/esc/conda-zsh-completion conda-zsh-completion" \
  "https://github.com/TamCore/autoupdate-oh-my-zsh-plugins autoupdate"
do
  set -- $plugin
  [ -d "${ZSH_CUSTOM}/plugins/$2" ] || git clone --depth=1 "$1" "${ZSH_CUSTOM}/plugins/$2" 2>/dev/null || true
done

# Custom switcher plugin (kubecontext switch / kcuc alias helper)
mkdir -p ${ZSH_CUSTOM}/plugins/switch
cp -f ./dotfiles/switcher.zsh ${ZSH_CUSTOM}/plugins/switch/

###############################################################################
# Auto-loaded oh-my-zsh custom files (aliases, exports, functions, ...)      #
###############################################################################
for f in aliases.zsh exports.zsh functions.zsh private.zsh ssh_tab_colors.zsh; do
  cp -f "./dotfiles/$f" "${ZSH_CUSTOM}/$f"
done

###############################################################################
# Shell dotfiles                                                               #
###############################################################################
cp -f .zshrc ~/.zshrc
cp -f .p10k.zsh ~/.p10k.zsh
cp -f .vimrc ~/.vimrc
cp -f .lessfilter ~/.lessfilter
touch ~/.hushlogin

###############################################################################
# Git config                                                                   #
###############################################################################
bash scripts/git.sh

###############################################################################
# Tmux                                                                         #
# Live layout: ~/.tmux/{tmux.conf,tmux.remote.conf,...} + ~/.tmux.conf symlink#
###############################################################################
mkdir -p ~/.tmux
cp -f ./tmux/tmux.conf ./tmux/tmux.remote.conf ./tmux/renew_env.sh ./tmux/yank.sh ~/.tmux/
chmod +x ~/.tmux/renew_env.sh ~/.tmux/yank.sh
ln -sf ~/.tmux/tmux.conf ~/.tmux.conf

# TPM + plugins (explicit clones so recovery doesn't depend on tpm state)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
for plugin in \
  "tmux-plugins/tmux-sensible" \
  "tmux-plugins/tmux-resurrect" \
  "tmux-plugins/tmux-prefix-highlight" \
  "tmux-plugins/tmux-battery" \
  "tmux-plugins/tmux-copycat" \
  "tmux-plugins/tmux-open" \
  "tmux-plugins/tmux-sidebar" \
  "samoshkin/tmux-plugin-sysstat"
do
  name=$(basename "$plugin")
  if [ ! -d "~/.tmux/plugins/$name" ]; then
    git clone --depth=1 "https://github.com/$plugin" ~/.tmux/plugins/$name 2>/dev/null || true
  fi
done

echo "Terminal setup done. Open a new shell to apply."
