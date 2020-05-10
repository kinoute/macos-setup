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
brew install zsh

# Install more recent versions of some OS X tools.
brew install vim
brew install grep
brew install openssh
brew install screen

# Install other useful binaries.
brew install bfg
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install git-delta
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
brew install wget
brew install watch
brew install mas
brew install fzf
brew install htop
brew install fd
brew instal ncdu
brew install ipython
brew install ngrok

# Core Casks
brew cask install flux
brew cask install spotify
brew cask install vlc
brew cask install the-unarchiver
brew cask install lulu
brew cask install onyx
brew cask install transmission
brew cask install slack


# Apps fom Mac App Store
mas install '1440147259' # Adguard For Safari
mas install '1429386865' # Nightlight (dark mode in Safari)

# Hackintosh stuff
# the newest version of karabiner seems buggy, use 12.3.0 instead
# brew cask install karabiner-elements
brew cask install https://raw.githubusercontent.com/Homebrew/homebrew-cask/4df3cd10135add216efff6a6feac9793d3c7910f/Casks/karabiner-elements.rb
brew install neofetch

# Remove mouse acceleration
brew tap homebrew/cask-drivers
brew cask install steelseries-exactmouse-tool

# Development tool casks
brew cask install iterm2
brew cask install sublime-text
brew cask install virtualbox
brew cask install brave-browser
brew cask install miniconda
brew cask install visual-studio-code

# Correct PHP code
brew install php-cs-fixer
brew install php-code-sniffer
brew install phpcbf
brew install phpmd

# Fix Ruby Code
gem install rubocop

# Format Python code
brew install black

# Install Docker, which requires virtualbox
brew cask install docker
brew install docker-compose
brew install lazydocker

# Fonts
brew tap homebrew/cask-fonts
brew cask install font-roboto-mono
brew cask install font-roboto-mono-for-powerline

# Better quick look support
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install qlvideo
brew cask install suspicious-package
brew cask install webpquicklook
brew cask install quicklook-csv
brew cask install betterzip

# Waiting for the author to accept my PR: https://github.com/tuxu/ipynb-quicklook/pull/7
# brew cask install jupyter-notebook-viewer
sudo cp -r ./misc/ipynb-quicklook.qlgenerator /Library/QuickLook

# restart quick look
qlmanage -r

# Remove outdated versions from the cellar.
brew cleanup
