# fzf picker for zoxide under curent dir
# ignore .git folder
fz() {
  local result
  result=$(fd -Htd -E '.git' | fzf -q "$*" -m --preview 'tree -C {}')

  if [[ -n "$result" ]]; then
    z "$result"
  fi
}
