# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias docs="cd ~/Documents"
alias dls="cd ~/Downloads"
alias desk="cd ~/Desktop"
alias sites="cd ~/sites"
alias python=python3
alias pip=pip3
alias cat="bat --style=plain --paging=never --italic-text=always"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias top=htop
alias cp='cp -iv'
alias mv='mv -iv'
alias r='refresh'
alias o='open .'
alias h='history'
alias v='vim'
alias drmi='docker rm `docker ps -a | grep Exited | grep -o -e "[0-9a-z]\{12\}"`; docker rmi `docker images | grep \<none\> | grep -o -e "[0-9a-z]\{12\}"`'
alias k='k9s -c context'
alias dig='dog'
alias kubectl='kubecolor'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
  export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
  colorflag="-G"
  export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List all files colorized in long format
if [[ ! -x "$(command -v exa)" ]]; then
  alias l="ls -lF ${colorflag}"
  alias ld="ls -lfash ${colorflag} */"
  alias lf="ls -lfash ${colorflag} -p | grep -v '/'"
else
  alias l="exa -l -h --icons --classify -a --ignore-glob='.DS_Store' --color always"
  alias ld="exa -l -h --icons --classify -a -d --color always */"
  alias lf="exa -l -h --icons --classify -a --color always | grep -v '/'"

  # Tree replacements
  TREE_IGNORE=".git|cache|log|logs|node_modules|vendor"

  # Folders
  alias ldt='l --tree -D -L 2 -I ${TREE_IGNORE}'
  alias ldtt='l --tree -D -L 3 -I ${TREE_IGNORE}'
  alias ldttt='l --tree -D -L 4 -I ${TREE_IGNORE}'
  alias ldtttt='l --tree -D -L 5 -I ${TREE_IGNORE}'

  # With files
  alias lt='l --tree -L 2 --group-directories-first -I ${TREE_IGNORE}'
  alias ltt='l --tree -L 3 --group-directories-first -I ${TREE_IGNORE}'
  alias lttt='l --tree -L 4 --group-directories-first -I ${TREE_IGNORE}'
  alias ltttt='l --tree -L 5 --group-directories-first -I ${TREE_IGNORE}'
fi

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Tree colors
alias tree="tree -C"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files and python cache folders
alias cleanup="find -E . -regex '.*(\.DS_Store|__pycache__|\.mypy_cache|\.pytest_cache|~).*' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]));"'

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# Lock the screen (when going AFK)
alias afk="osascript -e 'tell app \"System Events\" to keystroke \"q\" using {control down, command down}'"

# Reload the shell (i.e. invoke as a login shell)
alias refresh='source ~/.zshrc; echo "Reloaded .zshrc."'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Show and copy SSH Key to Clipboard
alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'SSH Key Copied to clipboard.'"

# Fzf interactive rebase
alias gfrbi='git rebase -i $(git log --pretty=oneline --color=always | fzf --ansi | cut -d " " -f1)'

# Latest URLs visited with Safari with the date
alias safarihistory="sqlite3 ~/Library/Safari/History.db 'SELECT datetime(V.visit_time+978307200, \"unixepoch\", \"localtime\") AS datetime, I.url, V.title FROM history_visits V LEFT JOIN history_items I on V.history_item = I.id ORDER BY visit_time DESC LIMIT 500;'"
