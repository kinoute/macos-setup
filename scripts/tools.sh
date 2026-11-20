#!/usr/bin/env bash

###############################################################################
# Language version managers & global tooling                                 #
# - mise replaces nvm/rvm; its shim dir is on PATH from .zshrc               #
# - npm globals for agent/CLI tools                                          #
###############################################################################

set -uo pipefail

###############################################################################
# mise                                                                       #
###############################################################################
if ! command -v mise >/dev/null; then
  curl https://mise.run | sh
fi

# Global tool versions (mirrors ~/.config/mise/config.toml)
mkdir -p ~/.config/mise
cat > ~/.config/mise/config.toml <<'EOF'
[settings]
idiomatic_version_file_enable_tools = ["ruby"]

[settings.ruby]
compile = false

[tools]
ruby = "4.0.9"
node = "26"
EOF

mise install
export MISE_NO_UPDATE_CHECK=1

###############################################################################
# npm globals (agent toolchain)                                              #
###############################################################################
npm install -g \
  @anthropic-ai/claude-code \
  @biomejs/biome \
  @cyberstrike-io/cyberstrike \
  @earendil-works/pi-coding-agent \
  asar \
  cline \
  openai \
  pnpm \
  wscat

###############################################################################
# Secrets that live in the login keychain                                    #
# Fill these BEFORE first shell start - dotfiles/exports.zsh reads them      #
###############################################################################
for entry in gemini-api-key crowpus-api-key youtrack-mcp outline-mcp; do
  if security find-generic-password -s "$entry" -w >/dev/null 2>&1; then
    echo "keychain entry '$entry': present"
  else
    echo "keychain entry '$entry': MISSING - run:"
    echo "  security add-generic-password -U -s $entry -a kinoute -w <value>"
  fi
done
