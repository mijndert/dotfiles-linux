#!/usr/sbin/bash

# Install zsh plugins
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

if [ ! -d ~/.zsh/fzf-tab ]; then
    git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
fi

# Get the absolute path of the script directory
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create .config/k9s directory if it doesn't exist
mkdir -p ~/.config/k9s

# Symlink all dotfiles (ln -sf will overwrite existing symlinks)
ln -sf "$DOTFILES_DIR/.zshrc" ~
ln -sf "$DOTFILES_DIR/.alias" ~
ln -sf "$DOTFILES_DIR/.functions" ~
ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitconfig-personal" ~
ln -sf "$DOTFILES_DIR/.gitconfig-work" ~
ln -sf "$DOTFILES_DIR/.tmux.conf" ~
ln -sf "$DOTFILES_DIR/.vimrc" ~
ln -sf "$DOTFILES_DIR/.curlrc" ~
ln -sf "$DOTFILES_DIR/.ripgreprc" ~
ln -sf "$DOTFILES_DIR/k9s_config.yml" ~/.config/k9s/config.yaml