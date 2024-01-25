# dotfiles

personal setups and other things

# folders

- git - git configuration
- hammerspoon - contains automation scripts
- scripts - contains various bash/zsh scripts
- windows - window specific dot files
- unix - configuration for zsh and other programs
  - .config
    - starship - shell prompt
    - kitty - terminal
    - karabiner - keybinding (for mac)

# Installation

0. Prereq
- Homebrew

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

1. Clone the repo

```
git clone git@github.com:hbish/dotfiles.git ~/.dotfiles
```

2. Install Brewfile

```
brew bundle --file ~/.dotfiles/Brewfile
```

3. Make zsh as default shell (not required for Mac)

```
chsh -s /usr/local/bin/zsh
```

4. Symlink manually (todo write script here)

```
cd ~/.dotfiles
stow <folder_name>
```

5. Hammerspoon

Set up the `~/.hammerspoon` directory (note, hammerspoon configs can not be a symlink).

Enable `Privacy & Security > Accessibility` access for Hammerspoon