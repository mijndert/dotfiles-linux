#!/usr/sbin/bash

# Arch Linux setup script
set -e

echo "Starting Arch Linux setup..."

# Update system and install packages
echo "Updating system and installing packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel zsh nodejs npm kubectl terraform helm fzf gawk direnv aws-cli opentofu k9s go-task

# Change shell to zsh for current user
echo "Changing shell to zsh..."
sudo usermod -s /bin/zsh $USER

# Set timezone
echo "Setting timezone to Europe/Amsterdam..."
sudo ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

# Install yay AUR helper as mijndert user
echo "Installing yay AUR helper..."
sudo -u mijndert bash -c 'cd /home/mijndert && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm'

# Install zsh plugins
echo "Installing zsh plugins..."
sudo -u mijndert yay -S --noconfirm zsh-pure-prompt zsh-autosuggestions zsh-completions zsh-syntax-highlighting

echo "Arch Linux setup complete!"