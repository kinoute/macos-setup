#!/usr/bin/env bash

###############################################################################
# Main Installation File to run everything on a brand new Mac                #
# Run from the repo root                                                     #
###############################################################################

set -uo pipefail
cd "$(dirname "$0")"

echo "==> 1/7 Homebrew formulae (k8s, git, dev tools)..."
bash ./scripts/brew.sh

echo "==> 2/7 Apps & GUI tools (casks, fonts, App Store)..."
bash ./scripts/apps.sh

echo "==> 3/7 macOS interface defaults..."
bash ./scripts/macos.sh

echo "==> 4/7 Language version managers (mise) & npm globals..."
bash ./scripts/tools.sh

echo "==> 5/7 Git configuration..."
bash ./scripts/git.sh

echo "==> 6/7 SSH key (interactive if none exists)..."
bash ./scripts/ssh.sh

echo "==> 7/7 Terminal, Zed and tmux..."
bash ./scripts/terminal.sh
bash ./scripts/zed.sh

echo ""
echo "DONE!"
echo "Manually finish with: 1Password, Microsoft Office, GPG Keychain, Crowpus."
echo "Then open a new terminal and check that your keychain entries exist:"
echo "  gemini-api-key, crowpus-api-key, youtrack-mcp, outline-mcp"
