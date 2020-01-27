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

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  node          # Node.js section
  elixir        # Elixir section
  xcode         # Xcode section
  golang        # Go section
  docker        # Docker section
  venv          # virtualenv section
  pyenv         # Pyenv section
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  char          # Prompt character
)

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"