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

sudo pacman -Syu --noconfirm
sudo pacman -S git lazygit fzf neovim starship zsh nnn zoxide base-devel \
  openssh ripgrep tldr btop nodejs npm unzip iwd ttf-jetbrains-mono-nerd \
  man-pages zsh-autosuggestions man-db entr python-pip python-libtmux \
  tmux bat --noconfirm

echo "configuring git"
git config --global user.name "tleoutline"
git config --global user.email "tleoutline@gmail.com"


echo "installing yay"
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
sudo rm -r yay-bin
yay -Syu --noconfirm
yay -S code-minimap lsd --noconfirm

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/yuhonas/zsh-aliases-lsd ${ZSH_CUSTOM}/plugins/zsh-aliases-lsd
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cd zsh-syntax-highlighting/themes/
mkdir ~/.zsh/
cp -v ./* ~/.zsh/
cd ../..
sudo rm -r zsh-syntax-highlighting

echo "installing tmux"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
cp ./tmux.conf ~/.config/tmux/tmux.conf

echo "installing astronvim"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone git@github.com:tleoutline/astronvim_config.git ~/.config/nvim/lua/user

echo "installing nnn plugins"
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"

echo "installing btop themes"
git clone https://github.com/catppuccin/btop.git
cp ./btop/themes/* ~/.config/btop/themes/
rm -rf btop

cp ./.profile ~/.profile
cp -r ./.ssh ~
chmod 700 ~/.ssh
chmod 600 ~/.ssh/gh-key
