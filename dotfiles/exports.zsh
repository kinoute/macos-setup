# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export PATH="/usr/local/opt/ruby@2.6/bin:$PATH"

# Go
export GOPATH=$HOME/sites/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GO111MODULE=on

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig:/opt/X11/lib/pkgconfig:/usr/local/opt/libffi/lib/pkgconfig

# Oh my Zsh framework
export ZSH=~/.oh-my-zsh

# Term Colors
export TERM=xterm-256color

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Binutils
export PATH="/usr/local/opt/binutils/bin:$PATH"

# Sphinx
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# curl auto complete
export FPATH="/usr/local/opt/curl/share/zsh/site-functions:$FPATH"

# opt out telemetry
export DO_NOT_TRACK=1

# Default AWS profile
export AWS_PROFILE="default"

# Kubectl plugins
export PATH="${PATH}:${HOME}/.krew/bin"
