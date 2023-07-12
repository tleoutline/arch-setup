#!/bin/sh

if pacman -Qi sudo &> /dev/null; then
    echo "sudo is already installed."
else
    echo "sudo is not installed. Installing sudo..."
    if pacman -Sy sudo --noconfirm; then
        echo "sudo installed successfully."
    else
        echo "Failed to install sudo."
        exit 1
    fi
fi

sudo pacman -S git lazygit fzf neovim starship zsh nnn zoxide base-devel \
  openssh ripgrep tldr btop nodejs npm unzip iwd --noconfirm

cp -R ./.ssh ~/

echo "installing yay"
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "installing astronvim"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone git@github.com:tleoutline/astronvim_config.git ~/.config/nvim/lua/user/lua/user/
