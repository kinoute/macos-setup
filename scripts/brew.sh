#!/usr/bin/env bash

###############################################################################
# Install every Homebrew formula this Mac relies on                          #
# Generated from the live machine (Nov 2026) - sync with `brew leaves`       #
###############################################################################

set -uo pipefail

# Check for Homebrew, install if we don't have it
if ! test -x "$(command -v brew)"; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

###############################################################################
# Third-party taps                                                           #
# Recent Homebrew refuses untrusted taps: trust them first                   #
###############################################################################
brew trust fluxcd/tap          2>/dev/null || true
brew trust norwoodj/tap        2>/dev/null || true
brew trust danielfoehrkn/switch 2>/dev/null || true
brew trust alesbrelih/gitlab-ci-ls 2>/dev/null || true
brew trust robusta-dev/krr     2>/dev/null || true
brew trust jadolg/tap          2>/dev/null || true
brew trust steipete/tap        2>/dev/null || true
brew trust jurplel/homebrew-tap 2>/dev/null || true
brew trust sdenike/homebrew-tap 2>/dev/null || true
brew trust go-task/homebrew-tap 2>/dev/null || true

###############################################################################
# Kubernetes & GitOps                                                        #
###############################################################################
brew install fluxcd/tap/flux
brew install helm
brew install helm-ls
brew install norwoodj/tap/helm-docs
brew install kustomize
brew install krew
brew install kubecolor
brew install kubeseal
brew install kubeconform
brew install kubevious
brew install kind
brew install kubectl
brew install robusta-dev/krr/krr
brew install prometheus
brew install terraform
brew install ansible
brew install cmctl
brew install cdk8s
brew install sops
brew install mkcert
brew install danielfoehrkn/switch/switch   # switcher / kcuc alias

# kubectl plugins (best effort - krew index handling changed in 0.4+)
kubectl krew index add kvaps https://github.com/kvaps/krew-index 2>/dev/null || true
kubectl krew index add k8s https://github.com/kubernetes-sigs/krew-index 2>/dev/null || true
for plugin in \
  k8s/access-matrix k8s/blame k8s/browse-pvc k8s/cnpg k8s/deprecations \
  k8s/df-pv k8s/duplicate k8s/get-all k8s/ice k8s/ktop k8s/kubescape \
  k8s/view-secret k8s/view-serviceaccount-kubeconfig k8s/who-can \
  kvaps/node-shell
do
  kubectl krew install "$plugin" 2>/dev/null || echo "krew plugin $plugin failed"
done

###############################################################################
# CI / scanning / security                                                   #
###############################################################################
brew install git-crypt
brew install git-filter-repo
brew install gitleaks
brew install hadolint
brew install trivy
brew install age
brew install binwalk
brew install tesseract

###############################################################################
# Languages & runtimes                                                       #
###############################################################################
brew install go
brew install node
brew install python@3.11
brew install uv
brew install ipython
brew install jq
brew install yq
brew install prettier
brew install python-lsp-server
brew install golangci-lint
brew install goreleaser
brew install shellcheck
brew install shfmt
brew install pre-commit
brew install eslint
brew install k6
brew install awscli
brew install awscli@1
brew install scw
brew install s5cmd
brew install step
brew install openjdk
brew install basictex 2>/dev/null || brew install --cask basictex

###############################################################################
# Kubernetes-adjacent cloud tools                                            #
###############################################################################
brew install gitlab-ci-ls 2>/dev/null || brew install alesbrelih/gitlab-ci-ls/gitlab-ci-ls
brew install bore-cli

###############################################################################
# Dev environment utilities                                                  #
###############################################################################
brew install coreutils    # gdate, gsed, ... (used by aliases)
brew install findutils
brew install gnu-sed
brew install gawk
brew install grep
brew install openssh
brew install screen
brew install tmux
brew install htop
brew install watch
brew install ncdu
brew install pv
brew install tree
brew install rename
brew install wget
brew install curl
brew install ffmpeg
brew install graphviz
brew install exiftool
brew install poppler
brew install qpdf
brew install protobuf
brew install dive
brew install nmap
brew install lesspipe
brew install lnav
brew install csvkit
brew install csvlens
brew install xsv
brew install tidy-viewer
brew install chafa
brew install eza
brew install fd
brew install ripgrep
brew install the_silver_searcher
brew install fzf
brew install bat
brew install autojump
brew install entr
brew install lsyncd
brew install ssh-copy-id
brew install subversion
brew install xcodegen
brew install bfg
brew install ghidra
brew install jadx
brew install cmake
brew install pkgconf
brew install libmagic
brew install moreutils
brew install mas
brew install pinentry-mac
brew install terminal-notifier
brew install doggo

###############################################################################
# Git                                                                        #
###############################################################################
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install git-delta
brew install gh
brew install glab

brew cleanup
