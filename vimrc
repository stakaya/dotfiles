" spaceをLeaderに割当
let mapleader = "\<space>"

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
		set runtimepath+=$HOME\vimfiles\plugins\plugins\repos\github.com\Shougo\dein.vim
	else 
		set runtimepath+=~/.vim/plugins/repos/github.com/Shougo/dein.vim/
	endif
endif

if has('win32') || has('win64')
	let s:plugins = expand($HOME.'\vimfiles\plugins') 

	" WindowsでPATHに$VIMが含まれていない時に
	" currentのexeを見つけ出せないので追加
	if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
		let $PATH = $VIM . ';' . $PATH
	endif
else 
	let s:plugins = expand('~/.vim/plugins')
endif

" プラグインの読み込み
if dein#load_state(s:plugins)
	call dein#begin(s:plugins)
	call dein#load_toml(s:plugins . '/plugins.toml', {'lazy': 0})
	call dein#load_toml(s:plugins . '/plugins_lazy.toml', {'lazy': 1})
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

" エンコーディング指定
set encoding=utf-8
set ambiwidth=double
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan
set fileformats=unix,dos,mac

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mMj
set noshowmode      " モードを表示しない
set nofoldenable 		" 折りたたみしない
set laststatus=2  	" ステータス行を表示
set noswapfile     	" スワップファイル不要 
set vb t_vb=     		" ビープ音を鳴らさない
set splitbelow  		" 新規ウインドウを下に表示
set cursorline 			" カーソル行をハイライト
set hlsearch 				" ハイライトサーチ
set history=50			" 履歴の保持数
set ignorecase 			" 検索時、大文字・小文字を気にせず
set iminsert=0      " IMEをデフォルトオフ
set imsearch=-1     " IMEをデフォルトオフ 
set incsearch				" インクリメンタルサーチ
set nowrap          " ワープしない
set number          " 行番号表示
set ruler		    		" カーソル行を常に表示
set showcmd		    	" コマンドの候補を表示
set virtualedit=all " カーソル位置を自由に設定する
set mouse=a					" マウスを使う
set shiftwidth=4    " シフト幅                   
set tabstop=4       " タブ幅
set autoindent     	" 自動インデント
set smartindent    	" プログラミング用インデント

" vimgrepをripgrepに入れ替える 
if executable('rg')
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ステータス行の指定
set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l:%c

" 自動的にインデントプラグインを読み込む
filetype plugin indent on

" 拡張子によってタブ幅を変更
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.svelte,*.ts,*.js,*.md,*.html,*.css,*.rb,*vimrc* setlocal tabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.php,*.c,*.cpp,*.java,*.kt,*.js setlocal cindent expandtab shiftround
augroup END

" 設定ファイルを編集コマンド 
command! Reload source $HOME/dotfiles/vimrc
command! Config edit $HOME/dotfiles/vimrc

" カレントウィンドウにのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

" カレントディレクトリを移動
autocmd BufEnter * if isdirectory(expand('%:p:h')) | lcd %:p:h | endif

" completeoptの設定
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

" ハイライトサーチ解除
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" ターミナル
noremap <silent> <leader>t :terminal<CR>

" 画面移動
noremap <silent> <leader>w :Buffers<CR>

" 文字置換   
nnoremap <leader>r "zyiw:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>
vnoremap <leader>r "zy:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>

" 範囲選択文字置換   
vnoremap <C-r> :s///g<Left><Left><Left>

" 合計値を計算
vnoremap <silent> <leader>sum :'<,'>!awk '{sum += $1} END {print sum}'<CR> 

" カウント
vnoremap <leader>count g<C-a> 

" 文字コードをUTF-8にする
nnoremap <leader>utf :set ff=unix<CR>:set fileencoding=utf-8<CR>

" grepコマンド
nnoremap <leader>* "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:vimgrep /<C-r>// **/*.* \|cw

" キーワードをgrep
nnoremap <silent> <leader>g "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>
vnoremap <silent> <leader>g "zy:let @/ = @z<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR> 

function! GrepGitFiles(keyword)
	let is_git = system('git status')
	if v:shell_error
		exe ':vimgrep /' . a:keyword . '/ ** | cw'
	else
		exe ':vimgrep /' . a:keyword . '/ `git ls-files %:p:h` | cw'
	endif
endfunction
