#!/bin/bash

DOT_FILES=(gvimrc vimrc vim)

for file in ${DOT_FILES[@]}
do
	if [ ! -e ~/$file ]; then
		echo "~/$file"
		ln -s $HOME/dotfiles/$file $HOME/.$file
	fi
done

[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

