# dotfiles

## Installation

Run the following command to automatically set up the dotfiles:

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/stakaya/dotfiles/master/setup.sh)"
```

## What this does

This command downloads and executes the setup script which:
- Clones the dotfiles repository (if running for the first time)
- Creates symbolic links for configuration files
- Sets up your shell environment
- Configures various applications like vim, tmux, etc.

## Components

This dotfiles repository includes configurations for:
- Zsh shell
- Vim/Neovim
- Tmux
- Git
- Alacritty terminal
- Starship prompt
- And more

## Custom Configuration

You can modify any of these configuration files to suit your preferences after installation.
