if !has('nvim')
	source $VIMRUNTIME/defaults.vim
	if has('win32') || has('win64')
		set pythonthreedll=$LOCALAPPDATA\Programs\Python\Python38\python38.dll
	endif
endif

if has('vim_starting')
	let &t_SI .= "\e[6 q" " 挿入モード縦棒カーソル
	let &t_EI .= "\e[2 q" " ノーマルモードブロックカーソル
	let &t_SR .= "\e[4 q" " 置換モード下線カーソル

	set runtimepath+=~/.vim/plugins/dein.vim/
	set runtimepath+=$HOME\vimfiles\plugins\dein.vim
endif

if has('win32') || has('win64')
	source $HOME\_vimrc.keymap
	call dein#begin(expand($HOME.'\vimfiles\plugins'))
else 
	source ~/.vim/../vimrc.keymap
	call dein#begin(expand('~/.vim/plugins/'))
endif

call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler', { 'depends' : ['Shougo/unite.vim'] })
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
call dein#add('vim-scripts/Align')
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('leafgarland/typescript-vim')
call dein#add('peitalin/vim-jsx-typescript')
call dein#add('andymass/vim-matchup')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('koron/dicwin-vim')
call dein#add('koron/verifyenc-vim')
call dein#add('vifm/vifm.vim')

call dein#end()

" indent_guidesの設定
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme *.js :hi IndentGuidesOdd  guibg=#2f2f2f ctermbg=236
autocmd VimEnter,Colorscheme *.js :hi IndentGuidesEven guibg=#2f2f2f ctermbg=236

" calendarの設定
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" lightlineの設定
let g:lightline = { 'colorscheme': 'wombat' }

" VimFilerの設定
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:netrw_liststyle = 3

" OS毎の設定
if has('mac')
	autocmd BufWritePost * call SetUTF8Xattr(expand('<afile>'))

	" デフォルトの'iskeyword'がcp932に対応しきれていないので修正
	set iskeyword = @,48-57,_,128-167,224-235    

	" 編集箇所に移動
	" <A-[> <A-]> 
	nnoremap “ g;
	nnoremap ‘ g,

	" インサート時のカーソル移動
	" <A-j> <A-k> <A-h> <A-l> 
	imap ˙  <Left>
	imap ∆ <Down>
	imap ˚  <Up>
	imap ¬ <Right>
elseif has('win32') || has('win64') 
	" WindowsでPATHに$VIMが含まれていない時にexeを見つけ出せないので修正
	if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
		let $PATH = $VIM . ';' . $PATH
	endif

	" 編集箇所に移動
	nnoremap <A-[> g;
	nnoremap <A-]> g,
endif

" completeoptの設定
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

" 自動的にインデントプラグインを読み込む
filetype plugin indent on

" カラー指定
colorscheme darcula

" ハイライトサーチ解除
nnoremap <silent> <ESC><ESC> :noh<CR>

" カレントウィンドウにのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

set noshowmode
set nofoldenable 	" 折りたたみしない
set ambiwidth=double
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan " エンコーディング指定
set fileformats=unix,dos,mac " 改行コードの自動認識
set laststatus=2  	" ステータス行を表示
set noswapfile     	" スワップファイル不要 
set vb t_vb=     	" ビープ音を鳴らさない
set virtualedit=all
set formatoptions+=mM " テキスト挿入中の自動折り返しを日本語に対応させる
set encoding=utf-8

" vimgrepをripgrepに入れ替える 
if executable('rg')
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ステータス行の指定
set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l:%c

" spaceをLeaderに割当
let mapleader = "\<Space>"

" phpの設定
autocmd FileType php compiler php
autocmd FileType php setlocal makeprg=php\ -l\ %
autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" 文字検索   
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" 文字置換   
nnoremap <leader>r "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>

" キーワードをgrep
nnoremap <leader>g "zyiw:let @/ = @z<CR>:set hlsearch<CR>:vimgrep /<C-r>// * \|cw<CR>

"------------------------------------
" tcomment_vim
"------------------------------------
nnoremap <leader>/ :TComment<CR>
vnoremap <leader>/ :TComment<CR>
nnoremap <D-/> :TComment<CR>
vnoremap <D-/> :TComment<CR>

"------------------------------------
" open-blowser.vim
"------------------------------------
" カーソル下のURLをブラウザで開く
map <leader>b <Plug>(openbrowser-open)
" 選択中のキーワードをググる
vnoremap <leader>b :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>

"------------------------------------
" utf出力時フラグセット
"------------------------------------
function! SetUTF8Xattr(file)
	let isutf8 = &fileencoding == 'utf-8' || (&fileencoding == '' && &encoding == 'utf-8')
	if has('unix') && match(system('uname'),'Darwin') != -1 && isutf8
		call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
	endif
endfunction

"------------------------------------
" fzf
"------------------------------------
nnoremap <leader><leader> :call FzfOmniFiles()<CR>
nnoremap <leader>; :Commands<CR>

fun! FzfOmniFiles()
	let is_git = system('git status')
	if v:shell_error
		:Files
	else
		:GitFiles
	endif
endfun

