#!/usr/bin/env bash

###############################################################################
# Use HomeBrew to install every package/app needed                            #
###############################################################################

# Check for Homebrew,
# Install if we don't have it
# Force the deletion of potential old homebrew installation
rm -rf /opt/homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
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
brew install yq
brew install ffmpeg
brew install ripgrep
brew install tmux
brew install bat
brew install exa
brew install wget
brew install watch
brew install mas
brew install fzf
brew install htop
brew install fd
brew install autojump
brew install ncdu
brew install ipython
brew install gpg
brew install pinentry
brew install pinentry-mac
brew install lnav
brew install ag
brew install xsv
brew install youtube-dl
brew install hadolint
brew install jupyter
brew install svn
brew install dive
brew install nmap
brew install lesspipe
brew install exiftool
brew install k9s
brew install kubectl
brew install kustomize
brew install krew
brew install kubeseal
brew install chafa
brew install csvkit
brew install tidy-viewer
brew install dog
brew install fluxcd/tap/flux
brew install kubecolor/tap/kubecolor
brew install eslint

# Add kubectl plugins
kubectl krew index add kvaps https://github.com/kvaps/krew-index
kubectl krew index add k8s https://github.com/kubernetes-sigs/krew-index

kubectl krew install kvaps/node-shell
kubectl krew install k8s/who-can
kubectl krew install k8s/ktop
kubectl krew install k8s/ice
kubectl krew install k8s/kubescape

# Core Casks
brew install --cask spotify
brew install --cask vlc
brew install --cask the-unarchiver
brew install --cask lulu
brew install --cask onyx
brew install --cask transmission
brew install --cask slack
brew install --cask ngrok

# Markdown editor
brew install typora

# Apps fom Mac App Store
mas install '1440147259' # Adguard For Safari

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
brew install pre-commit

# Go code
brew install golangci-lint
brew install goreleaser

# Install Docker, which requires virtualbox
brew install --cask docker
brew install docker-compose
brew install lazydocker

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-roboto-mono-nerd-font
brew install --cask font-roboto-mono-for-powerline
brew install font-roboto

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
