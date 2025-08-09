#!/usr/sbin/bash

# Arch Linux setup script
set -e

echo "Starting Arch Linux setup..."

# Update system and install packages
echo "Updating system and installing packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed git base-devel zsh nodejs npm kubectl terraform helm fzf gawk direnv aws-cli opentofu k9s go-task

# Change shell to zsh for current user
echo "Changing shell to zsh..."
sudo usermod -s /bin/zsh $USER

# Set timezone
echo "Setting timezone to Europe/Amsterdam..."
sudo ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

# Install yay AUR helper as mijndert user
echo "Installing yay AUR helper..."
sudo -u mijndert bash -c 'cd /home/mijndert && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm'
sudo -u mijndert bash -c 'rm -rf /home/mijndert/yay'

# Pure prompt
mkdir -p  /home/mijndert/.zsh
git clone https://github.com/sindresorhus/pure.git /home/mijndert/.zsh/pure

# Install k9s theme
OUT="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
mkdir -p "$OUT"
curl -L https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "$OUT" --strip-components=2 k9s-main/dist

# Place dotfiles 
echo "Placing dotfiles..."
mkdir -p /home/mijndert/dev/personal && mkdir -p /home/mijndert/dev/work
cd /home/mijndert/dev/personal
git clone https://github.com/mijndert/dotfiles-linux.git
cd dotfiles-linux
sh ./install.sh

echo "Arch Linux setup complete!"