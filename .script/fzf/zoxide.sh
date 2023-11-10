# fzf picker for zoxide under curent dir
# ignore .git folder
fz() {
  fd -Htd -E '.git' | fzf -q "$1" -m --preview 'tree -C {}' | xargs -r z
}
