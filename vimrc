source $VIMRUNTIME/defaults.vim

if has('vim_starting')
	set runtimepath+=~/.vim/plugins/dein.vim/
	set runtimepath+=$VIM\vim81\plugins\dein.vim
endif

if has("win32")
	call dein#begin(expand('$VIM\vim81\plugins'))
else 
	call dein#begin(expand('~/.vim/plugins/'))
endif

call dein#add('Shougo/vimproc.vim', {'build':{'mac' : 'make -f make_mac.mak'}})
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimshell')
call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
	call dein#add('roxma/nvim-yarp')
	call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler', { 'depends' : ['Shougo/unite.vim'] })
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-qfreplace')
call dein#add('tpope/vim-surround')
call dein#add('banyan/recognize_charcode.vim')
call dein#add('itchyny/calendar.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('kannokanno/previm')
call dein#add('kana/vim-fakeclip')
call dein#add('koron/dicwin-vim')
call dein#add('koron/verifyenc-vim')
call dein#add('mattn/webapi-vim')
call dein#add('mattn/gist-vim')
call dein#add('mattn/emmet-vim')
call dein#add('plasticboy/vim-markdown')
call dein#add('shinchu/hz_ja.vim')
call dein#add('tpope/vim-abolish')
call dein#add('tomtom/tcomment_vim')
call dein#add('tyru/open-browser.vim')
call dein#add('tyru/urilib.vim')
call dein#add('taku-o/vim-toggle')
call dein#add('blueshirts/darcula')
call dein#add('vim-scripts/autodate.vim')
call dein#add('vim-scripts/Alig')

call dein#end()

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

elseif has("win32") || has("win64") 
	set encoding=cp932

	" WindowsでPATHに$VIMが含まれていない時にexeを見つけ出せないので修正
	if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
		let $PATH = $VIM . ';' . $PATH
	endif
endif

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

" GUIで起動された場合シンタックスを有効にして検索ハイライトする
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

colorscheme darcula " カラー指定

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
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan " エンコーディング指定
set fileformats=unix,dos,mac " 改行コードの自動認識
set ignorecase 		" 検索時、大文字・小文字を気にせず
set iminsert=0
set imsearch=-1
set laststatus=2  	" ステータス行を表示
set noswapfile     	" スワップファイル不要 
set nowrap
set number
set shiftwidth=4
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

