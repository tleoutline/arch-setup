# Install packages using yay (change to pacman/AUR helper of your choice)
yayin() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}' --preview-window 'right,70%' | xargs -ro yay -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
yayrm() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' --preview-window 'right,70%' | xargs -ro yay -Rns
}
