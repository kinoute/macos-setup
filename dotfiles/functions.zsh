
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
