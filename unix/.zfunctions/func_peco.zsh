# Function to load Go Sources
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

# Function to load my projects
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
