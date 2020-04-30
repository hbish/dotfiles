#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000

EDITOR="vim"

# set options
setopt    append_history               # don't overwrite history
setopt    extended_history             # [unset]
setopt    hist_find_no_dups            # [unset] ignore dupes in history search
setopt    hist_ignore_dups             # this will not put _consecutive_ duplicates in the history
setopt    hist_ignore_space            # if any command starts with a whitespace, it will not be saved. it will stil be displayed in the current session, though
setopt    hist_verify                  # [unset] when doing history substitution, put the substituted line into the line editor

alias dc=docker-compose
alias idea='open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`"'
alias bs_jenv="find $HOME/.sdkman/candidates/java -type d -maxdepth 1 -mindepth 1 -exec jenv add '{}' \;"

export PATH=".:$HOME/miniconda3/bin:$PATH"
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# SDKMAN
export SDKMAN_DIR="/Users/bshi/.sdkman"
[[ -s "/Users/bshi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bshi/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.jenv/bin:$PATH"

eval "$(jenv init -)"
eval "$(jenv enable-plugin export)"

eval "$(starship init zsh)"

export PATH="/usr/local/opt/libpq/bin:$PATH"

# GO related config
export GOPATH="/Users/bshi/dev/go"
export PATH="$GOPATH/bin:$PATH"

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin


# functions

## Go Projects
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER" --layout=bottom-up)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src


function peco-prj () {
  local selected_dir=$(ls -d $HOME/prj/* | peco --query "$LBUFFER" --layout=bottom-up)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-prj
bindkey '^[' peco-prj
