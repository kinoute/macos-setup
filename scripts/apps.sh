#!/usr/bin/env bash

###############################################################################
# Apps & GUI tools                                                           #
# brew casks + Mac App Store + a few manual installs                         #
# Corporate MDM apps (JamfProtect, Stormshield, Self Service SAHAR,          #
# SaharUpdates) are managed by IT and intentionally NOT installed here.      #
###############################################################################

set -uo pipefail

brew trust jadolg/tap         2>/dev/null || true
brew trust steipete/tap       2>/dev/null || true
brew trust jurplel/homebrew-tap 2>/dev/null || true
brew trust sdenike/homebrew-tap 2>/dev/null || true
brew trust go-task/homebrew-tap 2>/dev/null || true

###############################################################################
# Editors & terminals                                                        #
###############################################################################
brew install --cask zed            # Preview/dev builds: see scripts/zed.sh
brew install --cask iterm2
brew install --cask sublime-text   # legacy, still used for some settings files

###############################################################################
# Container / VM / mobile                                                    #
###############################################################################
brew install --cask docker-desktop
brew install --cask utm
brew install --cask android-platform-tools

###############################################################################
# Daily drivers                                                              #
###############################################################################
brew install --cask brave-browser
brew install --cask vlc
brew install --cask spotify
brew install --cask the-unarchiver
brew install --cask lulu
brew install --cask protonvpn
brew install --cask signal
brew install --cask thunderbird
brew install --cask libreoffice
brew install --cask xcode        # or: xcode-select --install + Xcode from MAS

###############################################################################
# Productivity & window management                                           #
###############################################################################
brew install --cask alt-tab
brew install --cask hidden-revived            # sdenike tap
brew install --cask instant-space-switcher    # jurplel tap
brew install --cask space-rabbit
brew install --cask kaleidoscope
brew install --cask typora

###############################################################################
# AI / agent tooling                                                         #
###############################################################################
brew install --cask codex
brew install --cask codexbar                 # steipete tap
brew install --cask szero                    # jadolg tap (SwiftZero, Go dev)
brew install --cask ghidra
brew install --cask go-task                  # go-task tap

###############################################################################
# QuickLook plugins                                                          #
###############################################################################
brew install --cask qlmarkdown
brew install --cask qlvideo
brew install --cask quicklook-video
brew install --cask suspicious-package
brew install --cask jupyter-notebook-viewer
qlmanage -r

###############################################################################
# Fonts (installed in ~/Library/Fonts on the live machine)                   #
###############################################################################
brew install --cask font-meslo-lg-nerd-font     # Powerlevel10k
brew install --cask font-roboto-mono-nerd-font
brew install --cask font-roboto

###############################################################################
# Mac App Store                                                              #
###############################################################################
command -v mas >/dev/null || brew install mas
mas install 1569813296   # 1Password for Safari
mas install 1440147259   # AdGuard Mini
mas install 408981434    # iMovie
mas install 409183694    # Keynote
mas install 409203825    # Numbers
mas install 409201541    # Pages
mas install 803453959    # Slack
mas install 1414865219   # Olvid

###############################################################################
# Manual installs (no brew cask worth using)                                 #
###############################################################################
# 1Password           https://agilebits.com/start   (or: brew install --cask 1password)
# Microsoft Office    via your license / MDM
# GPG Keychain        bundled with Homebrew gnupg (pinentry-mac)
# Crowpus Desktop     internal distribution
echo "Manual installs to finish: 1Password, Microsoft Office, GPG Keychain, Crowpus"
