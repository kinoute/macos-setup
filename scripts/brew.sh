#!/usr/bin/env bash

###############################################################################
# Use HomeBrew to install every package/app needed                            #
###############################################################################

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

## Install cask
brew install cask

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# languages
brew install python
brew install php
brew install go
brew install zsh
brew install node

# Install more recent versions of some OS X tools.
brew install vim
brew install grep
brew install openssh
brew install screen
brew reinstall curl

# Install other useful binaries.
brew install bfg
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install git-delta
brew install lazygit
brew install imagemagick
brew install pv
brew install rename
brew install ssh-copy-id
brew install tree
brew install pandoc
brew install jq
brew install ffmpeg
brew install ripgrep
brew install bat
brew install exa
brew install wget
brew install watch
brew install mas
brew install fzf
brew install htop
brew install fd
brew install autojump
brew instal ncdu
brew install ipython
brew install gpg
brew install pinentry
brew install pinentry-mac
brew install lnav
brew install ag

# Core Casks
brew install --cask flux
brew install --cask spotify
brew install --cask vlc
brew install --cask the-unarchiver
brew install --cask lulu
brew install --cask onyx
brew install --cask transmission
brew install --cask slack
brew install --cask ngrok

# Apps fom Mac App Store
mas install '1440147259' # Adguard For Safari
mas install '1429386865' # Nightlight (dark mode in Safari)

# Hackintosh stuff
# the newest version of karabiner seems buggy, use 12.3.0 instead
# brew install --cask karabiner-elements
brew install --cask https://raw.githubusercontent.com/Homebrew/homebrew-cask/4df3cd10135add216efff6a6feac9793d3c7910f/Casks/karabiner-elements.rb
brew install neofetch

# Remove mouse acceleration
brew tap homebrew/cask-drivers
brew install --cask steelseries-exactmouse-tool

# Development tool casks
brew install --cask iterm2
brew install --cask sublime-text
brew install --cask virtualbox
brew install --cask brave-browser
brew install --cask miniconda
brew install --cask visual-studio-code

# Correct PHP code
brew install php-cs-fixer
brew install php-code-sniffer
brew install phpcbf
brew install phpmd

# Fix Ruby Code
gem install rubocop

# Fix Shell scripts
brew install shellcheck
brew install shfmt

# Format Python code
brew install black

# Install Docker, which requires virtualbox
brew install --cask docker
brew install docker-compose
brew install lazydocker

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-robotomono-nerd-font

# Better quick look support
brew install --cask qlcolorcode
brew install --cask qlstephen
brew install --cask qlmarkdown
brew install --cask quicklook-json
brew install --cask qlprettypatch
brew install --cask qlvideo
brew install --cask suspicious-package
brew install --cask webpquicklook
brew install --cask quicklook-csv
brew install --cask betterzip

# sse jupyter notebooks from quicklook
brew install --cask jupyter-notebook-viewer

# restart quick look
qlmanage -r

# Remove outdated versions from the cellar.
brew cleanup
