#!/usr/bin/env bash

###############################################################################
# Configure Git                                                               #
###############################################################################

# Copy gitignore and gitconfig template files
sudo cp ./gitfiles/.* ~/

# Set-up name
read -p "Enter your Full Name for Git: " name
git config --global user.name "$name"

# Set-up email
read -p "Enter your Email for Git: " email
git config --global user.email "$email"

# Diff colors
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
