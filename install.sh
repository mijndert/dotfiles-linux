#!/usr/sbin/bash
# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab

# Get the absolute path of the script directory
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlink all dotfiles
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