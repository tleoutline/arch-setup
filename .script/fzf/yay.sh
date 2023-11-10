# Install packages using yay (change to pacman/AUR helper of your choice)
yayin() {
    yay -Slq | fzf -q "$*" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
yayrm() {
    yay -Qq | fzf -q "$*" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}
