#!/usr/bin/env bash

###############################################################################
# My Zsh                                                                      #
###############################################################################

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax highlightings
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# fish live suggestion/completions
git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-autocomplete

# completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# fzf tab completion
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# conda zsh completions
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion

# auto update third party plugins
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate

# Install PowerLevel10k theme
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/powerlevel10k

# Make terminal faster
touch ~/.hushlogin

# copy dotfiles and zshrc
cp ./dotfiles/* ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}
cp -f .zshrc ~/
cp -f .p10k.zsh ~/

###############################################################################
# Vim                                                                         #
###############################################################################

# install VIM Plugins Manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy my setup
cp -f .vimrc ~/

# Install plugins
vim +PluginInstall +qall

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Copy iterm Settings
sudo cp -f ./iterm/com.googlecode.iterm2.plist ~/Library/Preferences/

# Install Hivacruz theme for iTerm
open -a iTerm ./iterm/Hivacruz.itermcolors

# Install k9s custom skin based on Nord theme
cp -f ./iterm/k9s-skin.yml ~/Library/Application\ Support/k9s/skin.yml

# Install custom bat config and theme
mkdir ~/.config || true
cp -rf ./iterm/bat ~/.config || true
bat cache --build

# Install lessfilter for better preview
cp -f .lessfilter ~/

# Misc rc files
cp -f .condarc ~/
cp -f .gemrc ~/
cp -f .screenrc ~/
cp -f .wgetrc ~/
cp -f .tmux.conf ~/
