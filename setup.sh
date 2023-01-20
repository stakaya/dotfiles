#!/bin/sh
set -e
cd ~

if [ ! -f /usr/local/bin/brew ]
	then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		echo "Homebrew already installed."
fi

if [ ! -d ~/dotfiles ]
	then
		echo "Cloning dotfiles..."
		git clone https://github.com/stakaya/dotfiles.git
	else
		echo "dotfiles already cloned."
fi

cd dotfiles

echo "Installing software & library..."
brew bundle -v --file=./apps/Brewfile

echo "Setup zsh."
zsh -f setup_shell.sh && echo "Done."

echo "Setup vim."
bash -f setup_app.sh && echo "Done." 
