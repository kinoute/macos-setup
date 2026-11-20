function switch() {
  local DEFAULT_EXECUTABLE_PATH="switcher"
  local opts=()
  local EXECUTABLE_PATH=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --executable-path) EXECUTABLE_PATH="$1" ;;
      completion) opts+=("$1" --cmd switch) ;;
      *) opts+=("$1") ;;
    esac
    shift
  done

  EXECUTABLE_PATH="${EXECUTABLE_PATH:-$DEFAULT_EXECUTABLE_PATH}"

  local RESPONSE
  RESPONSE="$("$EXECUTABLE_PATH" "${opts[@]}")"
  [[ $? -ne 0 || -z "$RESPONSE" ]] && { printf "%s\n" "$RESPONSE"; return $?; }

  local prefix="__ "
  if [[ "$RESPONSE" != "$prefix"* ]]; then
    printf "%s\n" "$RESPONSE"
    return
  fi

  # Remove the prefix and process the response
  RESPONSE="${RESPONSE#"$prefix"}"
  local KUBECONFIG_PATH="${RESPONSE%%,*}"
  local remainder="${RESPONSE#*,}"
  local SELECTED_CONTEXT="${remainder%%,*}"

  [[ -z "$KUBECONFIG_PATH" || -z "$SELECTED_CONTEXT" ]] && { printf "%s\n" "$RESPONSE"; return; }

  local switchTmpDirectory="$HOME/.kube/.switch_tmp/config"
  [[ -n "$KUBECONFIG" && "$KUBECONFIG" == *"$switchTmpDirectory"* ]] && \rm -f "$KUBECONFIG"

  export KUBECONFIG="$KUBECONFIG_PATH"
  printf "switched to context %s\n" "$SELECTED_CONTEXT"
}

# Zsh completion function for switcher
compdef _switcher switcher

# Completion logic
_switcher() {
  local shellCompDirectiveError=1
  local shellCompDirectiveNoSpace=2
  local shellCompDirectiveNoFileComp=4
  local shellCompDirectiveFilterFileExt=8
  local shellCompDirectiveFilterDirs=16
  local shellCompDirectiveKeepOrder=32

  local lastParam lastChar flagPrefix requestComp out directive comp noSpace keepOrder
  local -a completions

  words=("${=words[1,CURRENT]}")
  lastParam="${words[-1]}"
  lastChar="${lastParam[-1]}"

  [[ "${lastParam}" =~ '-.*=' ]] && flagPrefix="-P ${BASH_REMATCH}"

  requestComp="${words[1]} __complete ${words[2,-1]}"
  [[ -z "$lastChar" ]] && requestComp="${requestComp} \"\""

  out=$(eval "$requestComp" 2>/dev/null)

  # Extract directive from last line of output
  local lastLine
  while IFS= read -r line; do
    lastLine="$line"
  done < <(printf "%s\n" "${out[@]}")

  directive=0
  [[ "${lastLine[1]}" = : ]] && { directive="${lastLine[2,-1]}"; out="${out[1,-$(( ${#lastLine} + 2 ))]}"; }

  local activeHelpMarker="_activeHelp_ "
  local endIndex=${#activeHelpMarker}
  local startIndex=$(( ${#activeHelpMarker} + 1 ))
  local hasActiveHelp=0

  while IFS= read -r comp; do
    if [[ "${comp[1,$endIndex]}" = "$activeHelpMarker" ]]; then
      comp="${comp[$startIndex,-1]}"
      [[ -n "$comp" ]] && compadd -x "$comp" && hasActiveHelp=1
      continue
    fi
    [[ -n "$comp" ]] && completions+=("${comp//:/\\:}")
  done < <(printf "%s\n" "${out[@]}")

  [[ $hasActiveHelp -eq 1 && (${#completions[@]} -ne 0 || $((directive & shellCompDirectiveNoFileComp)) -eq 0) ]] && compadd -x "--"

  [[ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]] && noSpace="-S ''"
  [[ $((directive & shellCompDirectiveKeepOrder)) -ne 0 ]] && keepOrder="-V"

  if [[ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]]; then
    _arguments '*:filename:_files -g *.'${completions[@]}
  elif [[ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]]; then
    _arguments '*:dirname:_files -/'
  else
    _describe "$keepOrder" "completions" completions "$flagPrefix" "$noSpace" || return 1
    [[ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]] && _arguments '*:filename:_files'
  fi
}
