#!/usr/bin/env bash

###############################################################################
# Zed editor                                                                 #
# Note: the live machine runs a Preview/dev build ("Zed Preview.app",        #
# ~/Applications/Zed Dev.app for dev builds, `zed-fork` CLI). The brew cask  #
# below restores the stable channel - adjust if you want the preview one.    #
###############################################################################

set -uo pipefail
cd "$(dirname "$0")/.."

brew install --cask zed

###############################################################################
# Configuration                                                                #
###############################################################################
mkdir -p ~/.config/zed
cp -f ./zed/settings.json ~/.config/zed/settings.json
cp -f ./zed/keymap.json   ~/.config/zed/keymap.json
cp -f ./zed/tasks.json    ~/.config/zed/tasks.json

###############################################################################
# Extensions (language servers download themselves on demand)                 #
###############################################################################
for ext in \
  hivacruz-theme \
  material-icon-theme \
  colored-zed-icons-theme \
  color-highlight \
  rainbow-csv \
  emmet \
  git-firefly \
  mcp-server-context7 \
  mcp-server-gitlab \
  mcp-server-grafana \
  biome \
  terraform \
  helm \
  ansible \
  docker-compose \
  dockerfile \
  markdown-oxide \
  python-requirements \
  sql \
  toml \
  xml
do
  zed extension install "$ext" 2>/dev/null || echo "extension $ext failed (may need manual install)"
done

echo "Zed setup done."
