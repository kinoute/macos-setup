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
  git push
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
  # Check if environment.yml exists
  if [ -f "environment.yml" ]; then
    # Extract the environment name using yq and activate it
    env_name=$(yq eval '.name' environment.yml)
    conda activate "$env_name"
  fi

  subl_project=$(ls | grep "sublime-project" | head -n 1)
  if [ -z "$1" ]; then
    [ -n "$subl_project" ] && subl "$subl_project" && return 0
    # No sublime project found, open whole folder
    subl .
  else
    subl "$1"
  fi
}

function ssht() {
    tmux_session_name=${2:-"remote"}
    /usr/bin/ssh -t "$1" "which tmux 2>&1 > /dev/null && tmux -u -CC new -A -s $tmux_session_name"
}

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
fage() {
    vim \
        +'/\v'"${1/\//\\/}" \
        +':silent tabdo :1 | normal! n' \
        +':tabfirst' \
        -p $(ag "$@" | cut -d: -f1 | sort -u)
}

# Generate empty Kubernetes secret file
function gensecret() {
  cat <<EOF > $1.yaml.secret
apiVersion: v1
kind: Secret
metadata:
  name: ${1//secret-/}
  namespace: sahar-app
stringData:
  TEST: abc
EOF
subl "$1.yaml.secret"
}

# Seal secrets
function seal() {
  if [ ! -f "$HOME/Documents/Infra/Kubeseal/$1.pem" ]; then
    echo "$1.pem doesn't exist"
    return
  fi

  if [ ! -f "$2" ]; then
    echo "$2 doesn't exist"
    return
  fi

  sealed_secret="${2//.secret/}"
  kubeseal --cert "$HOME/Documents/Infra/Kubeseal/$1.pem" < "$2" > "$sealed_secret" -o yaml

  if [ "$?" -eq 0 ]; then
    echo "Secret $2 was sealed"

    # Don't open kustomization.yaml if it's already there
    [[ $(cat kustomization.yaml | grep -c "$sealed_secret") -ne 0 ]] && return

    # Add the sealed secret to kustomization.yaml
    echo "Adding secret to kustomization.yaml:"
    yq eval ".resources += [\"$sealed_secret\"]" -i kustomization.yaml
    # Sort entries
    yq eval '.resources |= sort' -i kustomization.yaml

  fi

}

# Unseal a Secret into a .secret file, to edit then `seal`. The source is a
# SealedSecret file from git, or <namespace>/<name> read from the cluster. The
# SealedSecret is decrypted with the controller keys and compared, key by key,
# with the Secret that runs: nothing is written unless they agree.
function unseal() {
  local context=$1 source=$2
  if [[ -z "$context" || -z "$source" ]]; then
    echo "usage: unseal <context> <sealed-secret.yaml | namespace/name>"
    return 1
  fi

  local sealed out name namespace
  if [[ -f "$source" ]]; then
    sealed=$(< "$source")
    out="$source.secret"
    name=$(print -r -- "$sealed" | yq 'select(.kind == "SealedSecret") | .metadata.name')
    namespace=$(print -r -- "$sealed" | yq 'select(.kind == "SealedSecret") | .metadata.namespace')
    if [[ -z "$name" || "$name" == *$'\n'* || "$namespace" == null ]]; then
      echo "$source must hold exactly one SealedSecret, with a namespace"
      return 1
    fi
  elif [[ "$source" == */* ]]; then
    namespace=${source%%/*} name=${source#*/}
    out="secret-$name.yaml.secret"
    sealed=$(kubectl --context "$context" -n "$namespace" \
      get sealedsecrets.bitnami.com "$name" -o yaml 2>/dev/null)
  else
    echo "$source is neither a file nor namespace/name"
    return 1
  fi

  # Private keys stay in this variable and in pipes, never on disk.
  local keys
  keys=$(kubectl --context "$context" -n kube-system get secret \
    -l sealedsecrets.bitnami.com/sealed-secrets-key -o yaml) || return 1

  local live
  live=$(kubectl --context "$context" -n "$namespace" get secret "$name" -o json) || return 1

  local template
  if [[ -n "$sealed" ]]; then
    local unsealed
    if ! unsealed=$(print -r -- "$sealed" | kubeseal --recovery-unseal \
      --recovery-private-key <(print -r -- "$keys") -o json); then
      echo "No key of $context decrypts $namespace/$name: it was sealed with another cluster's certificate"
      return 1
    fi

    # Names only: values never reach the terminal.
    local differing
    differing=$({ print -r -- "$unsealed"; print -r -- "$live"; } | jq -rs '
      (.[0].data // {}) as $sealed | (.[1].data // {}) as $live
      | ($sealed + $live | keys[]) | select($sealed[.] != $live[.])')
    if [[ -n "$differing" ]]; then
      echo "The SealedSecret and the Secret disagree on $namespace/$name, keys: ${differing//$'\n'/, }"
      echo "Deliberate: unseal won't pick which one is right. If the live Secret is, read it with:"
      echo "  kubectl --context $context -n $namespace get secret $name -o json | jq '.data | map_values(@base64d)'"
      return 1
    fi

    # Metadata from the SealedSecret template, so `seal` produces no stray diff.
    template=$(print -r -- "$sealed" | yq -o json '.spec.template')
  else
    echo "No SealedSecret $namespace/$name on $context: taking the live Secret as is"
    template=$(print -r -- "$live" | jq '{type, metadata: {labels: .metadata.labels,
      annotations: (.metadata.annotations // {}
        | del(."kubectl.kubernetes.io/last-applied-configuration")
        | if . == {} then null else . end)}}')
  fi

  # stringData is text: a binary value would not survive the round trip.
  local binary
  binary=$(print -r -- "$live" | jq -r '.data // {} | to_entries[]
    | select((.value | @base64d | @base64) != .value) | .key')
  if [[ -n "$binary" ]]; then
    echo "Binary keys, edit them by hand: ${binary//$'\n'/, }"
    return 1
  fi

  # A local .secret can be the only copy of a value that never reached git.
  if [[ -f "$out" ]]; then
    local stale
    stale=$({ print -r -- "$live"; yq -o json '.' "$out"; } | jq -rs '
      (.[0].data // {}) as $live
      | ((.[1].data // {}) + (.[1].stringData // {} | map_values(@base64))) as $local
      | ($live + $local | keys[]) | select($live[.] != $local[.])')
    if [[ -n "$stale" ]]; then
      echo "$out already exists and differs from the cluster on: ${stale//$'\n'/, }"
      echo "Move it away first if the cluster is right."
      return 1
    fi
  fi

  { print -r -- "$template"; print -r -- "$live"; } | jq -s '
    .[0] as $template | .[1] as $secret
    | {apiVersion: "v1", kind: "Secret",
       metadata: ({name: $secret.metadata.name, namespace: $secret.metadata.namespace}
         + ({labels: $template.metadata.labels, annotations: $template.metadata.annotations}
            | with_entries(select(.value != null))))}
    + (if $template.type then {type: $template.type} else {} end)
    + {stringData: ($secret.data // {} | map_values(@base64d))}' | yq -P > "$out"

  # seal uses this certificate offline: a foreign one is how 19 SealedSecrets
  # ended up undecryptable.
  local pem="$HOME/Documents/Infra/Kubeseal/$context.pem"
  if [[ -f "$pem" ]]; then
    local pem_fingerprint known_fingerprints
    pem_fingerprint=$(openssl x509 -in "$pem" -noout -fingerprint -sha256)
    known_fingerprints=$(print -r -- "$keys" | yq '.items[].data."tls.crt"' | while read -r cert; do
      print -r -- "$cert" | base64 -d | openssl x509 -noout -fingerprint -sha256
    done)
    if ! grep -qxF -- "$pem_fingerprint" <<< "$known_fingerprints"; then
      echo "WARNING: $pem matches no key of $context, seal would produce a SealedSecret it cannot decrypt"
    fi
  else
    echo "WARNING: $pem is missing, seal will refuse"
  fi

  local seal_command="seal $context ${out:t}"
  [[ "${out:h}" != . ]] && seal_command="cd ${out:h} && $seal_command"
  echo "Wrote $out. Edit it, then: $seal_command"
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
        names=("${(@s::)${1}}")
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

# Add IP route to OpenVPN whitelist
function wl() {
  local ovpn_file="/Users/kinoute/Library/Application Support/OpenVPN Connect/profiles/1790447436226.ovpn"
  local ip="$1"
  local comment="$2"

  # Validate arguments
  if [[ -z "$ip" ]]; then
    echo "Usage: wl <ip> [comment]"
    echo "Example: wl 1.2.3.4 \"K8s cluster\""
    return 1
  fi

  # Check if IP already exists in the file
  if grep -q "route $ip " "$ovpn_file" 2>/dev/null; then
    echo "IP $ip is already in the whitelist"
    return 1
  fi

  # Build the route line
  local route_line="route $ip 255.255.255.255 vpn_gateway"
  if [[ -n "$comment" ]]; then
    route_line="$route_line # $comment"
  fi

  # Append to the file
  echo "$route_line" >> "$ovpn_file"
  echo "Added: $route_line"

  # Restart OpenVPN Connect
  echo "Restarting OpenVPN Connect..."
  osascript -e 'quit app "OpenVPN Connect"'
  sleep 1
  open -a "OpenVPN Connect"
  echo "Done. Please reconnect to VPN if needed."
}
