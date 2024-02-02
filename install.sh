#!/bin/sh

prompt() {
    local prompt="$1"
    local userInput

    read -p "$prompt (Y/n): " userInput

    if [[ -z "$userInput" || "$userInput" =~ ^[Yy]$ ]]; then
        echo "true"
    else
        echo "false"
    fi
}

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

DOTFILES_PATH="~/.config/dotfiles"
git clone git@github.com:/tleoutline/arch-dotfiles.git $DOTFILES_PATH

echo "installing yay"
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
sudo rm -r yay-bin
yay -Syu --noconfirm
yay -S code-minimap lsd autoenv-git --noconfirm

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/urbainvaes/fzf-marks.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-marks
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cd zsh-syntax-highlighting/themes/
mkdir ~/.zsh/
cp -v ./* ~/.zsh/
cd ../..
sudo rm -r zsh-syntax-highlighting
if [ $(prompt "install .zshrc?")  == "true"]; then
    ln -s $DOTFILES_PATH/.zshrc ~/.zshrc
if

if [ $(prompt "install starship.toml?")  == "true"]; then
    ln -s $DOTFILES_PATH/starship.toml ~/.config/starship.toml
fi

echo "installing tmux"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
if [ $(prompt "install tmux config files?")  == "true"]; then
    ln -s $DOTFILES_PATH/tmux.conf ~/.config/tmux/tmux.conf
fi

echo "installing astronvim"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone git@github.com:tleoutline/astronvim_config.git ~/.config/nvim/lua/user

echo "installing nnn plugins"
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"

echo "installing btop themes"
git clone https://github.com/catppuccin/btop.git
cp ./btop/themes/* ~/.config/btop/themes/
rm -rf btop

if [ $(prompt "install .profile?")  == "true"]; then
    ln -s $DOTFILES_PATH/.profile ~/.profile
fi

if [ $(prompt "install ssh config?")  == "true"]; then
    ln -s $DOTFILES_PATH/.sss/config ~/.ssh/config
fi
chmod 700 ~/.ssh
