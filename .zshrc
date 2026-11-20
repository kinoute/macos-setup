# =============================================================================
# PERFORMANCE & INSTANT PROMPT
# =============================================================================
# Uncomment to profile zsh startup time
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt (must be near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# OH-MY-ZSH CONFIGURATION
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
DEFAULT_USER=kinoute

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Tmux integration
ZSH_TMUX_AUTOSTART='true'
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# =============================================================================
# PLUGINS
# =============================================================================
plugins=(
    git
    z
    fluxcd
    python
    macos
    kubectl
    docker
    docker-compose
    fzf
    zsh-autosuggestions
    zsh-autocomplete
    zsh-completions
    autoupdate
    fast-syntax-highlighting
)

# =============================================================================
# COMPLETION SETUP (before oh-my-zsh)
# =============================================================================
fpath=(/opt/homebrew/opt/curl/share/zsh/site-functions/ $fpath)
fpath=(/opt/homebrew/opt/awscli@1/share/zsh/site-functions $fpath)
fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)

# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# =============================================================================
# FAST COMPSINIT (skip full audit + dump unless >24h old)
# Must run before oh-my-zsh; the no-op below makes omz's compinit a no-op.
# =============================================================================
export ZSH_DISABLE_COMPFIX=true
autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
  compinit -C -d "$HOME/.zcompdump"
else
  compinit -d "$HOME/.zcompdump"
fi
compinit() { : }

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# =============================================================================
# ZSH-AUTOCOMPLETE CONFIGURATION
# =============================================================================
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:recent-dirs' backend z
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:list-choices:*' max-lines 100%

# Group completions
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'

# Colorize completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Disable ssh auto-completion with /etc/hosts
zstyle ':completion:*:(ssh|scp|rsync):*' hosts off

# =============================================================================
# FZF-TAB CONFIGURATION
# =============================================================================
# Default preview with less
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:*' fzf-flags --preview-window=right --height=99%
export LESSOPEN='|~/.lessfilter %s'

# Disable preview for options and subcommands
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
zstyle ':fzf-tab:complete:*:argument-2' fzf-preview

# Enhanced cd preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# Git checkout sorting
zstyle ':completion:*:git-checkout:*' sort false

# Switch groups with comma and period
zstyle ':fzf-tab:*' switch-group ',' '.'

# =============================================================================
# DOCKER COMPLETION
# =============================================================================
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':omz:plugins:docker' legacy-completion yes

# =============================================================================
# SSH HOST COMPLETION
# =============================================================================
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:scp:*' hosts $h
  zstyle ':completion:*:rsync:*' hosts $h
  zstyle ':completion:*:ssht:*' hosts $h
  zstyle ':completion:*:sshpf:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# =============================================================================
# KEY BINDINGS
# =============================================================================
# Up arrow: search history
bindkey '\e[A' up-line-or-history
bindkey '\eOA' up-line-or-history

# =============================================================================
# CUSTOM COMPLETIONS
# =============================================================================
# Function to generate and cache completions
generate_completion() {
    local cmd=$1
    local comp_file="$ZSH_CACHE_DIR/completions/_${cmd}"
    local omz_file="$HOME/.oh-my-zsh/completions/_${cmd}"

    if [[ ! -f $comp_file ]]; then
        case $cmd in
            flux)
                flux completion zsh > "$omz_file" 2>/dev/null && cp "$omz_file" "$comp_file"
                ;;
            switcher)
                switcher init zsh > "$omz_file" 2>/dev/null && cp "$omz_file" "$comp_file"
                ;;
            uv)
                uv generate-shell-completion zsh > "$omz_file" 2>/dev/null && cp "$omz_file" "$comp_file"
                ;;
            switch)
                switch completion zsh > "$omz_file" 2>/dev/null && cp "$omz_file" "$comp_file"
                ;;
            kubectl)
                kubectl completion zsh > "$comp_file" 2>/dev/null
                cp "$comp_file" "$ZSH_CACHE_DIR/completions/_kubecolor"
                ;;
            scw)
                # le script embarque "autoload -U compinit && compinit" qu'on supprime pour ne pas relancer un compinit complet au startup
                scw autocomplete script 2>/dev/null | grep -v '^autoload -U compinit' > "$omz_file" && cp "$omz_file" "$comp_file"
                ;;
        esac
    fi
}

# Generate completions
for cmd in flux switcher uv switch kubectl scw; do
    generate_completion $cmd
done

# Source completions
for comp in kubectl kubecolor flux uv switch switcher scw; do
    [[ -f "$ZSH_CACHE_DIR/completions/_${comp}" ]] && source "$ZSH_CACHE_DIR/completions/_${comp}"
done

# Fix uv completion: disable "show all possibilities" prompt
zstyle ':completion:*:*:uv:*' list-prompt ''
zstyle ':completion:*:*:uv:*' select-prompt ''
zstyle ':completion:*:*:uv:*' menu yes select

# Source switcher plugin
[[ -f "$ZSH_CUSTOM/plugins/switch/switcher.zsh" ]] && source "$ZSH_CUSTOM/plugins/switch/switcher.zsh"

# =============================================================================
# COMMAND ALIASES FOR COMPLETION
# =============================================================================
compdef kubecolor=kubectl
compdef ssht=ssh
compdef sshpf=ssh
compdef k=k9s

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================
export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export HISTFILESIZE=10000000

setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY

# =============================================================================
# POWERLEVEL10K THEME
# =============================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# NODE VERSION MANAGER
# =============================================================================
export NVM_DIR="$HOME/.nvm"

# Uncomment to profile zsh startup time
# zprof

# Added by Antigravity
export PATH="/Users/kinoute/.antigravity/antigravity/bin:$PATH"

# strix (avant mise activate, sinon strix passe devant les tools mise)
export PATH=/Users/kinoute/.strix/bin:$PATH

export MISE_NO_UPDATE_CHECK=1
export AUBE_NO_UPDATE_CHECK=1
# mise lazy: shims sur le PATH immédiatement, activation complète à la 1ère commande (-250 ms au startup)
export PATH="$HOME/.local/share/mise/shims:$PATH"
_mise_lazy_init() {
  add-zsh-hook -d preexec _mise_lazy_init
  unset -f _mise_lazy_init
  eval "$(mise activate zsh)"
}
add-zsh-hook preexec _mise_lazy_init

# Tokens MCP pour Codex (sourced depuis le keychain, mêmes entrées que Claude Code)
export YOUTRACK_MCP_TOKEN="Bearer $(security find-generic-password -s youtrack-mcp -w)"
export OUTLINE_MCP_TOKEN="Bearer $(security find-generic-password -s outline-mcp -w)"

case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
