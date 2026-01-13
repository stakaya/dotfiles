" Neovim設定ファイル
" 参考: https://neovim.io/
" 参考: https://github.com/neovim/neovim
" madox2/vim-ai
if exists('g:vscode')
  " VSCode Neovim拡張使用時
  source $HOME/dotfiles/vimrc.keymap
else
  " Lua設定を読み込み
  lua require('init')
endif
