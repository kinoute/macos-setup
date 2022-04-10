# short alt. to man, see few examples (ex: 'cheat curl')
function cheat() {
   curl cht.sh/$1
}

# Git add and git commit at the same time
function ac() {
  git add .
  git commit -m "$*"
}

# Git add, git commit and git push at the same time
function acp() {
  git add .
  git commit -m "$*"
  git push origin master
}

# create folder and enter it
function mkcd () {
  mkdir -p "$@" && cd "$@"
}

# Shows pretty `man` page.
function man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# Load .env file into shell session for environment variables
function envup() {
  if [ -f .env ]; then
    export $(sed '/^ *#/ d' .env)
  else
    echo 'No .env file found' 1>&2
    return 1
  fi
}

# Extract most know archives with one command
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

# Better alias to open sublime text projects
function s() {
  subl_project=$(ls | grep "sublime-project" | head -n 1)
  if [ -z "$1" ]; then
    [ -n "$subl_project" ] && subl "$subl_project" && return 0
    # No sublime project found, open whole folder
    subl .
  else
    subl "$1"
  fi
}

# Use Tmux for remote SSH connections
function ssht() {
    tmux_session_name=${2:-"remote"}
    ssh -t "$1" "which tmux 2>&1 > /dev/null && tmux -u -CC new -A -s $tmux_session_name"
}

# Simplest port foward function
function sshpf() {
  ssh -L $2:127.0.0.1:$2 $1 -N -f -o "ExitOnForwardFailure yes"
  if [ $? != "0" ]; then
    echo "Failed to port forward $1 on $2"
    return 1
  fi

  echo "Port forwarded service on port $2: http://localhost:$2"
  open "http://localhost:$2"
}

# Find in files with ripgrep + fzf + bat
function ff() {
  # 1. Search for text in files using Ripgrep
  # 2. Interactively restart Ripgrep with reload action
  # 3. Open the file in Vim
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  export LESSOPEN='|~/.lessfilter %s'
  selected=$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
    fzf --ansi \
        --multi \
        --reverse \
        --disabled \
        --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --delimiter : \
        --preview 'bat --style=numbers --color=always {1} --highlight-line {2}' \
        --preview-window '+{2}+3/3,~3'
  )

  # Rewrite finames + line to be opened with sublime text
  filenames=""
  while read file; do
    filenames+=$(echo "$file" | cut -d ':' -f1,2)
    filenames+=" "
  done < <(echo "$selected")

  # Open files with ST if we have some filenames
  [ -n "${selected}" ] && subl $(echo "$filenames" | xargs)
}


# find pattern with "age pattern" and open files with vim tabs
age() {
    vim \
        +'/\v'"${1/\//\\/}" \
        +':silent tabdo :1 | normal! n' \
        +':tabfirst' \
        -p $(ag "$@" | cut -d: -f1 | sort -u)
}

function lazy_load() {
    # Act as a stub to another shell function/command. When first run, it will load the actual function/command then execute it.
    # E.g. This made my zsh load 0.8 seconds faster by loading `nvm` when "nvm", "npm" or "node" is used for the first time
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    echo "Lazy loading $1 ..."

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

function group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}
