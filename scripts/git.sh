#!/usr/bin/env bash

###############################################################################
# Configure Git                                                               #
###############################################################################

# no gitconfig yet, copy template and ask infos
if [ ! -f ~/.gitconfig ]; then

  # Copy gitignore and gitconfig template files
  sudo cp -r -f ./gitfiles/.git* ~/

  # Set-up name
  read -p "Enter your Full Name for Git: " name
  git config --global user.name "$name"

  # Set-up email
  read -p "Enter your Email for Git: " email
  git config --global user.email "$email"

fi

# add gpg-agent config
mkdir ~/.gnupg
cp ./gpg-agent.conf ~/.gnupg/gpg-agent.conf
