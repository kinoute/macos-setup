#!/usr/bin/env bash

###############################################################################
# Configure Git                                                               #
###############################################################################

set -uo pipefail
cd "$(dirname "$0")/.."

# Copy gitconfig template (user block included)
if [ ! -f ~/.gitconfig ]; then
  cp -f ./gitfiles/.gitconfig ~/
fi

# GPG agent config for signing (key lives in 1Password/GPG Keychain)
mkdir -p ~/.gnupg
[ -f ~/.gnupg/gpg-agent.conf ] || cp -f ./gpg-agent.conf ~/.gnupg/gpg-agent.conf

echo "Git setup done."
