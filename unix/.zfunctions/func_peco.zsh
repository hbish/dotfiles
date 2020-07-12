# Function to load Go Sources
function peco-src () {
  local selected_dir=$(ls -d $HOME/dev/* | peco --query "$LBUFFER" --layout=bottom-up)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^[2' peco-src

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
bindkey '^[1' peco-prj
