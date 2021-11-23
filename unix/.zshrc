
source "$HOME/.zinit/bin/zinit.zsh"

# zinit annexes
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-bin-gem-node

# utilities
zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \

zinit ice \
    svn \
    wait \
    lucid \
    submods'zsh-users/zsh-completions -> external'

# zsh
HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000

EDITOR="vim"

setopt    append_history               # don't overwrite history
setopt    extended_history             # [unset]
setopt    hist_find_no_dups            # [unset] ignore dupes in history search
setopt    hist_ignore_dups             # this will not put _consecutive_ duplicates in the history
setopt    hist_ignore_space            # if any command starts with a whitespace, it will not be saved. it will stil be displayed in the current session, though
setopt    hist_verify                  # [unset] when doing history substitution, put the substituted line into the line editor

is_macos() {
    [[ "$OSTYPE" == darwin* ]]
}


# alias
alias vim=nvim
alias vi=nvim
alias dc=docker-compose
alias idea='open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`"'
alias bs_jenv="find $HOME/.sdkman/candidates/java -type d -maxdepth 1 -mindepth 1 -exec jenv add '{}' \;"
alias ssh='TERM="xterm-256color" kitty +kitten ssh'

# preferred prompt
zinit ice from"gh-r" as"program" pick"**/starship" \
    atload"!eval \$(STARSHIP_CONFIG=\"${HOME}/.config/starship.toml\" starship init zsh)"
zinit light starship/starship

export YSU_MESSAGE_FORMAT="💡 You should use: $(tput bold)%alias$(tput sgr0)"
export YSU_HARDCORE=0
zinit light MichaelAquilina/zsh-you-should-use

# ssh
zstyle :omz:plugins:ssh-agent identities id_rsa
zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh

# git
zinit snippet OMZ::plugins/git/git.plugin.zsh

# nodejs nvm
zinit load "lukechilds/zsh-nvm"

# java
source $HOME/.asdf/asdf.sh
if [ -d "$HOME/.asdf/plugins/java" ]; then
  zinit ice wait"0" pick".asdf/plugins/java/set-java-home.zsh" lucid
  zinit light %HOME
fi
zinit snippet OMZ::plugins/gradle/gradle.plugin.zsh

# asdf
zinit ice as"completion"
zinit snippet https://github.com/asdf-vm/asdf/blob/master/completions/_asdf

# Docker
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

# functions
if [ -f $HOME/.zfunctions/func_peco.zsh ]; then
	. $HOME/.zfunctions/func_peco.zsh
fi

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
alias d="kitty +kitten diff"

# local zshrc - customise for home/work
LOCAL_ZSHRC="$HOME/.zshrc.local"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
