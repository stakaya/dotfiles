if has('win32') || has('win64')
	" Windows環境：ホームディレクトリのgvimrcを読み込み
	source $HOME\_gvimrc
else
	" Unix系環境（macOS、Linux）：共通のgvimrcを読み込み
	source ~/.vim/../gvimrc
endif
