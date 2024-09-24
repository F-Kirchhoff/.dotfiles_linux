export TERM="xterm-256color" # This sets up colors properly

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit snippet OMZP::dirhistory

# load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Aliases
## shell
alias l="ls -l"
alias ll="ls -la"
alias ls="ls --color"
alias "cd -"="cd -- -"
alias ".."="cd .."
alias "..."="cd ../.."
alias "...."="cd ../../.."

## zsh
alias reload="source ~/.zshrc"

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh-history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

eval "$(/opt/homebrew/bin/brew shellenv)"

# wush
function wush {
  zsh <(curl -sSL "https://raw.githubusercontent.com/neuefische/web-push/main/wush.sh")
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go installations
export PATH=$PATH:/Users/ph1/go/bin/

# Set it so ~/.pyenv provides Python before others of the same name:
export PYENV_ROOT=$(pyenv root)
export PATH="$PYENV_ROOT/shims:$PATH"

# starship prompt
eval "$(starship init zsh)"

#fzf
eval "$(fzf --zsh)"

#z
eval "$(zoxide init --cmd cd zsh)"
