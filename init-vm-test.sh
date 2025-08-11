#!/usr/sbin/bash
set -e

# Function definitions
setup_mirror() {
  echo "Setting up mirror..."
  sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  sudo touch /etc/pacman.d/mirrorlist
  echo "Server = https://eu.mirror.archlinuxarm.org/\$arch/\$repo" | sudo tee /etc/pacman.d/mirrorlist
}

update_system() {
  echo "Updating system..."
  sudo pacman -Syu --noconfirm
}

install_packages() {
  packages=(
    git
    base-devel
    zsh
    nodejs
    npm
    kubectl
    terraform
    helm
    fzf
    gawk
    direnv
    aws-cli
    opentofu
    k9s
    go-task
    vim
    tmux
    ripgrep
    talosctl
    tree
    jq
  )
  echo "Installing packages: ${packages[*]}"
  sudo pacman -S --noconfirm --needed "${packages[@]}"
}

setup_shell() {
  echo "Changing shell to zsh..."
  sudo usermod -s /bin/zsh $USER
}

setup_timezone() {
  echo "Setting timezone to Europe/Amsterdam..."
  sudo ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
}

install_yay() {
  echo "Installing yay AUR helper..."
  sudo -u mijndert bash -c 'cd /home/mijndert && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm'
  sudo -u mijndert bash -c 'rm -rf /home/mijndert/yay'
}

setup_pure_prompt() {
  mkdir -p /home/mijndert/.zsh
  git clone https://github.com/sindresorhus/pure.git /home/mijndert/.zsh/pure
}

install_k9s_theme() {
  OUT="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
  mkdir -p "$OUT"
  curl -L https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "$OUT" --strip-components=2 k9s-main/dist
}

setup_dotfiles() {
  echo "Placing dotfiles..."
  mkdir -p /home/mijndert/dev/personal && mkdir -p /home/mijndert/dev/work
  cd /home/mijndert/dev/personal
  git clone git@github.com:mijndert/dotfiles-linux.git
  cd dotfiles-linux
  sh ./install.sh
}

run_all() {
  echo "Starting Arch Linux setup..."
  setup_mirror
  update_system
  install_packages
  setup_shell
  setup_timezone
  install_yay
  setup_pure_prompt
  install_k9s_theme
  setup_dotfiles
  echo "Arch Linux setup complete!"
}

# Command-line argument handling
case "${1:-all}" in
  mirror) setup_mirror ;;
  update) update_system ;;
  packages) install_packages ;;
  shell) setup_shell ;;
  timezone) setup_timezone ;;
  yay) install_yay ;;
  prompt) setup_pure_prompt ;;
  k9s) install_k9s_theme ;;
  dotfiles) setup_dotfiles ;;
  all|"") run_all ;;
  *)
    echo "Usage: $0 [mirror|update|packages|shell|timezone|yay|prompt|k9s|dotfiles|all]"
    echo "Available functions:"
    echo "  mirror    - Setup pacman mirror"
    echo "  update    - Update system packages"
    echo "  packages  - Install base packages"
    echo "  shell     - Change shell to zsh"
    echo "  timezone  - Set timezone"
    echo "  yay       - Install yay AUR helper"
    echo "  prompt    - Setup pure prompt"
    echo "  k9s       - Install k9s theme"
    echo "  dotfiles  - Setup dotfiles"
    echo "  all       - Run complete setup (default)"
    exit 1
    ;;