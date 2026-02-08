#!/usr/sbin/bash
set -e

echo "Starting Arch Linux setup..."

# Set mirror
# sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
# sudo touch /etc/pacman.d/mirrorlist
# echo "Server = https://eu.mirror.archlinuxarm.org/\$arch/\$repo" | sudo tee /etc/pacman.d/mirrorlist

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install packages
echo "Installing packages..."
./install-packages.sh

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
ssh-keyscan github.com > ~/.ssh/known_hosts
mkdir -p /home/mijndert/dev/personal && mkdir -p /home/mijndert/dev/work
cd /home/mijndert/dev/personal
git clone git@github.com:mijndert/dotfiles-linux.git
cd dotfiles-linux
sh ./install.sh

echo "Arch Linux setup complete!"
