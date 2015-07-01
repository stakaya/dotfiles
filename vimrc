if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler', { 'depends' : ['Shougo/unite.vim'] }
NeoBundle 'Shougo/neocomplcache.git'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'

NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/urilib.vim'

NeoBundle 'mattn/emmet-vim'

NeoBundle 'shinchu/hz_ja.vim'
NeoBundle 'koron/verifyenc-vim'

NeoBundle 'vim-scripts/autodate.vim'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'koron/dicwin-vim'

NeoBundle 'banyan/recognize_charcode.vim'

call neobundle#end()

if has("mac")
	set encoding=utf-8
	autocmd BufWritePost * call SetUTF8Xattr(expand("<afile>"))

	" デフォルトの'iskeyword'がcp932に対応しきれていないので修正
	set iskeyword=@,48-57,_,128-167,224-235    

	" メニューの日本語化 
	set langmenu=japanese

	" ヘルプタグ設定
	helptags ~/.vim/doc
endif

if has("win32")
	set encoding=cp932

	" WindowsでPATHに$VIMが含まれていない時にexeを見つけ出せないので修正
	if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
		let $PATH = $VIM . ';' . $PATH
	endif
endif

" ファイルを最後に保存してからどの部分が編集されたかDIFFを取るコマンド
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" マウスのホィールを有効にする
if has("mouse")
	set mouse=a
endif

" 自動的に閉じ括弧を入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" コロンとセミコロンを入れ替える
nnoremap ; :
nnoremap : ;

" 自動的にインデントプラグインを読み込む
filetype plugin indent on

augroup vimrcEx
	au!

	" テキストサイズは80カラム
	autocmd FileType text setlocal textwidth=80

	" ファイルが編集された時、カーソルを最適な位置に移動する
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif
augroup END

" GUIで起動された場合シンタックスを有効にして検索ハイライトする
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

colorscheme zenburn " カラー指定

" カーソル行をハイライト
set cursorline

" カレントウィンドウにのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

set clipboard=unnamed
set ambiwidth=double
set backspace=indent,eol,start " バックスペースキーで削除できるものを指定
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan " エンコーディング指定
set fileformats=unix,dos,mac " 改行コードの自動認識
set history=50		" keep 50 lines of command line history
set ignorecase 		" 検索時、大文字・小文字を気にせず
set iminsert=0
set imsearch=-1
set incsearch		" do incremental searching
set laststatus=2  	" ステータス行を表示
set nocompatible  	" viとの互換性をとらない(vimの独自拡張機能を使う)
set noswapfile     	" スワップファイル不要 
set nowrap
set number
set ruler		    " show the cursor position all the time
set shiftwidth=4
set showcmd		    " display incomplete commands
set tabstop=4
set vb t_vb=     	" ビープ音を鳴らさない
set virtualedit=all
set whichwrap=<,>,[,]
set formatoptions+=mM " テキスト挿入中の自動折り返しを日本語に対応させる 

" ステータス行の指定
set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l:%c

" phpコンパイル設定
autocmd FileType php compiler php
autocmd FileType php setlocal makeprg=php\ -l\ %
autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" ヴィジュアルモードの時にバックススペースで削除
vnoremap <BS> d

" CTRL-X と SHIFT-Del でカット
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C と CTRL-Insert でコピー
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V と SHIFT-Insert でペースト
map <C-V>		"+gP
map <S-Insert>		"+gP
cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" 範囲選択と貼りつけ
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" CTRL-Q で範囲選択
noremap <C-Q>		<C-V>

" CTRL-S でセーブ
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" CTRL-Z でundo
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y でredo
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" CTRL-A で全選択
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab でウインドウの切り替え
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

"------------------------------------
" open-blowser.vim
"------------------------------------

" カーソル下のURLをブラウザで開く
map <F2> <Plug>(openbrowser-open)
" カーソル下のキーワードをググる
map <F5> :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>

"------------------------------------
" utf出力時フラグセット
"------------------------------------
function! SetUTF8Xattr(file)
	let isutf8 = &fileencoding == "utf-8" || ( &fileencoding == "" && &encoding == "utf-8")
	if has("unix") && match(system("uname"),'Darwin') != -1 && isutf8
		call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
	endif
endfunction

