#!/bin/bash

DOT_FILES=(gvimrc vimrc ideavimrc vim vifm tmux.conf)

for file in ${DOT_FILES[@]}
do
	if [ ! -e ~/$file ]; then
		echo "~/$file"
		ln -s $HOME/dotfiles/$file $HOME/.$file
	fi
done

CONFIG_FILES=(nvim vifm)

if [ ! -e ~/.config ]; then
	mkdir -p ~/.config
fi

for file in ${CONFIG_FILES[@]}
do
	if [ ! -e ~/$file ]; then
		echo "~/$file"
		ln -s $HOME/dotfiles/$file $HOME/.config/$file
	fi
done

# vscode
ln -s $HOME/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
ln -s $HOME/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

[ ! -d ~/.vim/plugins/repos/github.com/Shougo/dein.vim ] && mkdir -p ~/.vim/plugins/repos/github.com/Shougo/dein.vim
git clone git://github.com/Shougo/dein.vim ~/.vim/plugins/repos/github.com/Shougo/dein.vim
