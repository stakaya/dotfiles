" Neovim設定ファイル
" 参考: https://neovim.io/
" 参考: https://github.com/neovim/neovim

scriptencoding utf-8
set clipboard=unnamed    " システムクリップボードを使用
set inccommand=split     " 置換時にリアルタイムプレビューを分割ウィンドウで表示

if exists('g:vscode')
  " VSCode Neovim拡張使用時
  source $HOME/.vimrc.keymap
elseif has('win32') || has('win64')
  " Windows環境
  source $HOME\_vimrc
  let g:python3_host_prog=$HOME.'\Programs\Python\Python39\python'
else
  " Unix系環境（macOS、Linux）
  source ~/.vim/../vimrc
  " Python3パスを動的に取得
  let g:python3_host_prog=substitute(system('which python3'),"\n","","")
endif
