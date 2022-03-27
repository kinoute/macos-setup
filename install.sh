#!/usr/bin/env bash

###############################################################################
# Main Installation File to run everything at once                            #
###############################################################################

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

echo "Installing brew packages first..."
bash ./scripts/brew.sh

echo "Setting up macOS just like we like..."
bash ./scripts/macos.sh

echo "Setting up Git.."
bash ./scripts/git.sh

echo "Setting up SSH Key.."
bash ./scripts/ssh.sh

echo "Setting up Terminal, ZSH and iTerm2.."
bash ./scripts/terminal.sh

echo "DONE!"
