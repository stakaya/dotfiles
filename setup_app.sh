#!/bin/bash

DOT_FILES=(gvimrc vimrc vimrc.keymap ideavimrc xvimrc vim)

for file in ${DOT_FILES[@]}
do
	if [ ! -e ~/$file ]; then
		echo "~/$file"
		ln -s $HOME/dotfiles/$file $HOME/.$file
	fi
done

ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
[ ! -d ~/.vim/plugins ] && mkdir -p ~/.vim/plugins && git clone git://github.com/Shougo/dein.vim ~/.vim/plugins/dein.vim
