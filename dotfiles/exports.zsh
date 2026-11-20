# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Python
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"

export PATH="/usr/local/opt/ruby@2.6/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH=$HOME/sites/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GO111MODULE=on

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig:/opt/X11/lib/pkgconfig:/usr/local/opt/libffi/lib/pkgconfig

# Oh my Zsh framework
export ZSH=~/.oh-my-zsh

# aws
export PATH="/opt/homebrew/opt/awscli@1/bin:$PATH"

# Term Colors
export TERM=xterm-256color

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Binutils
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
# Sphinx
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# curl
export FPATH="/usr/local/opt/curl/share/zsh/site-functions:$FPATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# opt out telemetry
export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1

export AWS_PROFILE="default"

# Kubectl plugins
export PATH="${PATH}:${HOME}/.krew/bin"

export GEMINI_API_KEY="$(security find-generic-password -s gemini-api-key -w 2>/dev/null)"

# Codex / Crowlingo / Crowpus
export CROWPUS_API_KEY="$(security find-generic-password -s crowpus-api-key -w 2>/dev/null)"

