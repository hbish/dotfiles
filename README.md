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

```/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```

- Stow (required for symlinking dotfiles)


1. Clone the repo

```
https://github.com/hbish/dotfiles.git ~/.dotfiles
```

2. Make zsh as default shell

```
chsh -s /usr/local/bin/zsh
```

3. Install prezto

4. Symlink

```
cd ~/.dotfiles
stow <folder_name>
```

5. Hammerspoon

Set up the `~/.hammerspoon` directory (note, hammerspoon configs can not be a symlink).

Enable `Privacy & Security > Accessibility` access for Hammerspoon