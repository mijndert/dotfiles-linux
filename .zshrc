export EDITOR=vim
export PATH=$PATH
export RIPGREP_CONFIG_PATH=~/.ripgreprc

fpath+=($HOME/.zsh/pure)

bindkey "^R" history-incremental-search-backward

setopt SHARE_HISTORY HIST_IGNORE_DUPS
SAVEHIST=5000
HISTFILE=~/.zsh_history

autoload -U promptinit; promptinit
autoload -Uz bashcompinit; bashcompinit
autoload -Uz compinit; compinit

zstyle :prompt:pure:git:stash show yes
prompt pure

complete -C '/usr/sbin/aws_completer' aws
complete -o nospace -C /usr/sbin/terraform terraform

source ~/.alias
source ~/.functions
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)
eval "$(direnv hook zsh)"