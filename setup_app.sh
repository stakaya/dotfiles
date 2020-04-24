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
[ ! -d ~/.vim/plugins ] && mkdir -p ~/.vim/plugins && git clone git://github.com/Shougo/dein.vim ~/.vim/plugins/dein.vim

