#!/bin/zsh
set -e

cd ~
if [ ! -d ~/dotfiles ]
then
	echo "dotfilesをクローン中..."
	git clone https://github.com/stakaya/dotfiles.git
else
	echo "dotfiles は既にクローン済みです。"
fi

cd dotfiles
echo "Zshをセットアップ中..."
zsh -f setup_shell.sh && echo "完了。"

echo "Vimをセットアップ中..."
zsh -f setup_app.sh && echo "完了。"
