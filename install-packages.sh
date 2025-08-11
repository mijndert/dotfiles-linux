# Define packages to install
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
    python
)

# Install packages
echo "Installing packages: ${packages[*]}"
sudo pacman -S --noconfirm --needed "${packages[@]}"