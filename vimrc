" spaceをLeaderに割当
let g:mapleader = "\<space>"

" カスタマイズキーマップを読み込み
source $HOME/dotfiles/vimrc.keymap

if !has('nvim')
	source $VIMRUNTIME/defaults.vim
	set clipboard=unnamed,autoselect
endif

if has('vim_starting')
	let &t_SI .= "\e[6 q" " 挿入モード縦棒カーソル
	let &t_EI .= "\e[2 q" " ノーマルモードブロックカーソル
	let &t_SR .= "\e[4 q" " 置換モード下線カーソル

	if has('win32') || has('win64')
		set runtimepath+=$HOME\vimfiles\plugins\repos\github.com\Shougo\dein.vim
	else
		set runtimepath+=~/.vim/plugins/repos/github.com/Shougo/dein.vim/
	endif
endif

if has('win32') || has('win64')
	let s:plugin_conf = expand($HOME.'\vimfiles\plugins')

	" WindowsでPATHに$VIMが含まれていない時に
	" currentのexeを見つけ出せないので追加
	if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
		let $PATH = $VIM . ';' . $PATH
	endif
else
	let s:plugin_conf = expand('~/.vim/plugins')
endif

if has('nvim')
	let s:pluins = expand('~/.config/nvim/plugins')
else
	let s:pluins = expand('~/.vim/plugins')
endif

" プラグインの読み込み
if dein#load_state(s:pluins)
	call dein#begin(s:pluins)
	call dein#load_toml(s:plugin_conf . '/plugins.toml', {'lazy': 0})
	call dein#load_toml(s:plugin_conf . '/plugins_lazy.toml', {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

" true color
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" terminal color
" black red green yellow blue magenta cyan white (bright is next line)
let g:terminal_ansi_colors = [
\ '#000000',
\ '#fd6b67',
\ '#097e00',
\ '#ccca00',
\ '#5496ef',
\ '#fd75ff',
\ '#39cbcc',
\ '#bbbbbb',
\ '#676767',
\ '#fd8784',
\ '#73f961',
\ '#fefb00',
\ '#7eaff4',
\ '#fd9cff',
\ '#6ed9d9',
\ '#f1f1f1',
\ ]

set ambiwidth=single   " 2バイト文字の表示
set autoindent         " 自動インデント
set autowrite          " 自動保存
set cursorline         " カーソル行をハイライト
set encoding=utf-8     " 文字コードはUTF8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan
set fileformats=unix,dos,mac
set formatoptions+=mMj " テキスト挿入中の自動折り返しを日本語に対応させる
set hlsearch           " ハイライトサーチ
set ignorecase         " 検索時、大文字・小文字を気にせず
set iminsert=0         " IMEをデフォルトオフ
set imsearch=-1        " IMEをデフォルトオフ
set incsearch          " インクリメンタルサーチ
set laststatus=2       " ステータス行を表示
set mouse=a            " マウスを使う
set nofoldenable       " 折りたたみしない
set nolist             " 制御コード不可視
set noshowmode         " モードを表示しない
set noswapfile         " スワップファイル不要
set nowrap             " ワープしない
set number             " 行番号表示
set ruler              " カーソル行を常に表示
set shiftwidth=4       " シフト幅
set showcmd            " コマンドの候補を表示
set smartindent        " プログラミング用インデント
set splitbelow         " 新規ウインドウを下に表示
set tabstop=4          " タブ幅
set vb t_vb=           " ビープ音を鳴らさない
set virtualedit=all    " カーソル位置を自由に設定する

" grepをripgrepに入れ替える
if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ステータス行の指定
set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l:%c

" 自動的にインデントプラグインを読み込む
filetype plugin indent on

" 拡張子によって変更
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap expandtab
	autocmd BufNewFile,BufRead *.svelte,*.ts,*.js,*.md,*.html,*.css,*.rb,*vimrc setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.php,*.c,*.cpp,*.java,*.kt,*.js setlocal cindent expandtab shiftround
augroup END

" バイナリファイルを開く場合
augroup Binary
	autocmd!
	autocmd BufReadPre  *.bin let &bin=1
	autocmd BufReadPost *.bin if &bin | %!xxd
	autocmd BufReadPost *.bin set ft=xxd | endif
	autocmd BufWritePre *.bin if &bin | %!xxd -r
	autocmd BufWritePre *.bin endif
	autocmd BufWritePost *.bin if &bin | %!xxd
	autocmd BufWritePost *.bin set nomod | endif
augroup END

" Yankでクリップボードにコピー
if executable('clip.exe')
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
elseif executable('wl-copy')
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('wl-copy', @")
  augroup END
elseif executable('xclip')
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('xclip', @")
  augroup END
endif

" 設定ファイルを編集コマンド
command! Reload source $HOME/dotfiles/vimrc
command! Config edit $HOME/dotfiles/vimrc

" カレントウィンドウにのみ罫線を引く
augroup cursorLine
	autocmd!
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

" カレントディレクトリを移動
autocmd BufEnter * if isdirectory(expand('%:p:h')) | lcd %:p:h | endif

" 自動でQuickfixオープン
autocmd QuickfixCmdPost make,grep,vimgrep copen

" completeoptの設定
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

" ハイライトサーチ解除
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" ターミナル
noremap <silent> <leader>t :terminal<CR>

" 文字置換
nnoremap <leader>r "zyiw:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>
vnoremap <leader>r "zy:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>

" 範囲選択文字置換
vnoremap <C-r> :s///g<Left><Left><Left>

" 合計値を計算
vnoremap <silent> <leader>sum :'<,'>!awk '{sum += $1} END {print sum}'<CR>

" カウント
vnoremap <silent> <leader>+ g<C-a>
vnoremap <silent> <leader>- g<C-A>
vnoremap <silent> <leader>index :s/^/\=printf("%d", line(".") - line("'<") + 1)/<CR>

" 文字コードをUTF-8にする
nnoremap <silent> <leader>utf :set ff=unix<CR>:set fileencoding=utf-8<CR>

" キーワードをgrep
nnoremap <silent> <leader>* "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>
vnoremap <silent> <leader>* "zy:let @/ = @z<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>

function! GrepGitFiles(keyword)
	let l:ex = '*.' . expand('%:e')
	if l:ex == '*.'
	  let l:ex = expand('%')
	endif
  let l:is_git = system('git status')
	if v:shell_error
		exe ':vimgrep /' . a:keyword . '/ **/' . l:ex
	else
		exe ':vimgrep /' . a:keyword . '/ `git ls-files %:p:h`'
	endif
endfunction
