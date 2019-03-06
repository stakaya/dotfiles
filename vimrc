if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	set runtimepath+=$VIM\vim74\bundle\neobundle.vim
endif

if has("win32")
	call neobundle#begin(expand('$VIM\vim74\bundle'))
else 
	call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler', { 'depends' : ['Shougo/unite.vim'] }
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'mac' : 'make -f make_mac.mak',
			\     'linux' : 'make'
			\    },
			\ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tpope/vim-surround'
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kannokanno/previm'
NeoBundle 'koron/dicwin-vim'
NeoBundle 'koron/verifyenc-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'shinchu/hz_ja.vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/urilib.vim'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'vim-scripts/autodate.vim'
NeoBundle 'Align'

call neobundle#end()

" vimshellの設定
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
	
	if has('win32') || has('win64')
	  " Display user name on Windows.
	  let g:vimshell_prompt = $USERNAME."% "
	else
	  " Display user name on Linux.
	  let g:vimshell_prompt = $USER."% "
	endif



" calendarの設定
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:lightline = { 'colorscheme': 'wombat' }

" neocompleteの設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" VimFilerの設定
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
 
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default=0
let g:netrw_liststyle=3
if has("mac")
	set encoding=utf-8
	autocmd BufWritePost * call SetUTF8Xattr(expand("<afile>"))

	" デフォルトの'iskeyword'がcp932に対応しきれていないので修正
	set iskeyword=@,48-57,_,128-167,224-235    

	" メニューの日本語化 
	set langmenu=japanese

	" ヘルプタグ設定
	" helptags ~/.vim/doc
endif

if has("win32")
	set encoding=cp932

	" WindowsでPATHに$VIMが含まれていない時にexeを見つけ出せないので修正
	if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
		let $PATH = $VIM . ';' . $PATH
	endif
endif

" ファイルを最後に保存してからどの部分が編集されたかDIFFを取るコマンド
"move to default| if !exists(":DiffOrig")
"move to default|	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"move to default| endif

" マウスのホィールを有効にする
if has("mouse")
	set mouse=a
endif

" 自動的に閉じ括弧を入力
imap {{ {}<LEFT>
imap [[ []<LEFT>
imap (( ()<LEFT>

" コロンとセミコロンを入れ替える
nnoremap ; :
nnoremap : ;

" 自動的にインデントプラグインを読み込む
filetype plugin indent on

"move to default| augroup vimrcEx
"move to default|	au!
"move to default|	" ファイルが編集された時、カーソルを最適な位置に移動する
"move to default|	autocmd BufReadPost *
"move to default|				\ if line("'\"") > 1 && line("'\"") <= line("$") |
"move to default|				\   exe "normal! g`\"" |
"move to default|				\ endif
"move to default| augroup END

" GUIで起動された場合シンタックスを有効にして検索ハイライトする
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

colorscheme Zenburn " カラー指定

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
"move to default| set backspace=indent,eol,start " バックスペースキーで削除できるものを指定
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan " エンコーディング指定
set fileformats=unix,dos,mac " 改行コードの自動認識
"move to default| set history=50		" keep 50 lines of command line history
set ignorecase 		" 検索時、大文字・小文字を気にせず
set iminsert=0
set imsearch=-1
"move to default| set incsearch		" do incremental searching
set laststatus=2  	" ステータス行を表示
"move to default| set nocompatible  	" viとの互換性をとらない(vimの独自拡張機能を使う)
set noswapfile     	" スワップファイル不要 
set nowrap
set number
"move to default| set ruler		    " show the cursor position all the time
set shiftwidth=4
"move to default|set showcmd		    " display incomplete commands
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

