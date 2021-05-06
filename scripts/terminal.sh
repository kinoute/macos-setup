#!/usr/bin/env bash

###############################################################################
# My Zsh                                                                      #
###############################################################################

# Install Zsh related stuff only if zsh is installed already
if [[ $(grep /zsh$ /etc/shells | tail -1) ]]; then

  # set up zsh as default shell
  chsh -s $(which zsh)

  # Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # Auto-suggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # syntax highlightings
  git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

  # completions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

  # fzf tab completion
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

  # auto update third party plugins
  git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate

  # Install PowerLevel10k theme
  git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/powerlevel10k

  # Make terminal faster
  touch ~/.hushlogin

  # copy dotfiles and zshrc
  cp ./dotfiles/* ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}
  cp -f .zshrc ~/

else

  echo 'Not installing Zsh-related stuff because ZSH is not installed. run "brew install zsh".'
  exit

fi

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

# Misc rc files
cp -f .condarc ~/
cp -f .gemrc ~/
cp -f .screenrc ~/
cp -f .wgetrc ~/
cp -f .tmux.conf ~/
