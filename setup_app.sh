#!/bin/bash

# link for dot files
DOT_FILES=(gvimrc vimrc ideavimrc vim vifm tmux.conf)
for file in ${DOT_FILES[@]}
do
	if [ ! -e ~/$file ]; then
		echo "~/$file"
		ln -s $HOME/dotfiles/$file $HOME/.$file
	fi
done

# make config directory
if [ ! -e ~/.config ]; then
	mkdir -p ~/.config
fi

# link for config directory
CONFIG_FILES=(nvim vifm alacritty starship.toml)
for file in ${CONFIG_FILES[@]}
do
	if [ ! -e ~/$file ]; then
		echo "~/$file"
		ln -s $HOME/dotfiles/$file $HOME/.config/$file
	fi
done

# link dictionary file
ln -s $HOME/dotfiles/vim/dict $HOME/dotfiles/nvim/dict

# down load plugin control
[ ! -d ~/.vim/plugins/repos/github.com/Shougo/dein.vim ] && mkdir -p ~/.vim/plugins/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim ~/.vim/plugins/repos/github.com/Shougo/dein.vim
