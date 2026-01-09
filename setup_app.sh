#!/bin/zsh

DOT_FILES=(vimrc vim vifm tmux.conf zsh)
for file in ${DOT_FILES[@]}
do
	if [ ! -e ~/.$file ]; then
		echo "リンク作成: ~/.$file"
		ln -s $HOME/dotfiles/$file $HOME/.$file
	fi
done

if [ ! -e ~/.config ]; then
	mkdir -p ~/.config
fi

# link for config directory and files
CONFIG_FILES=(vifm starship.toml git)
for file in ${CONFIG_FILES[@]}
do
	if [ ! -e ~/.config/$file ]; then
		echo "リンク作成: ~/.config/$file"
		ln -s $HOME/dotfiles/$file $HOME/.config/$file
	fi
done

# 参考: https://github.com/Shougo/dein.vim
[ ! -d ~/.vim/plugins/repos/github.com/Shougo/dein.vim ] && mkdir -p ~/.vim/plugins/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim ~/.vim/plugins/repos/github.com/Shougo/dein.vim
