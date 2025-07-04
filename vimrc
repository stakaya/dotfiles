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
  let s:plugin = s:plugin_conf

  " WindowsでPATHに$VIMが含まれていない時に
  " currentのexeを見つけ出せないので追加
  if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
  endif
else
  let s:plugin_conf = expand('~/.vim/plugins')
  if has('nvim')
    let s:plugin = expand('~/.config/nvim/plugins')
  else
    let s:plugin = expand('~/.vim/plugins')
  endif
endif

" プラグインの読み込み
if dein#load_state(s:plugin)
  call dein#begin(s:plugin)
  call dein#load_toml(s:plugin_conf . '/plugins.toml', {'lazy': 0})
  call dein#load_toml(s:plugin_conf . '/plugins_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Only check for removed plugins once per day to improve startup time
let s:cleanup_file = expand('~/.vim/.dein_cleanup_check')
let s:should_cleanup = !filereadable(s:cleanup_file) ||
  \ (localtime() - getftime(s:cleanup_file)) > 86400

if s:should_cleanup
  let s:removed_plugins = dein#check_clean()
  if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
  endif
  call writefile([string(localtime())], s:cleanup_file)
endif

" true color
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" terminal color
highlight Terminal guibg=#2a2a2a
highlight Terminal guifg=#bbbbbb

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
set nowrap             " 折返ししない
set number             " 行番号表示
set ruler              " カーソル行を常に表示
set shiftwidth=4       " シフト幅
set showcmd            " コマンドの候補を表示
set smartindent        " プログラミング用インデント
set splitbelow         " 新規ウインドウを画面の下に表示
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

" カレントウィンドウにのみ罫線を引く
augroup cursorLine
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" 自動的にインデントプラグインを読み込む
filetype plugin indent on

" 拡張子によって変更
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap expandtab
  autocmd BufNewFile,BufRead *.json,*.md,*.html,*.css,*.ts,*.js,*vimrc* setlocal tabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.php,*.c,*.java,*.kt,*.js setlocal cindent expandtab shiftround
  autocmd BufNewFile,BufRead *.rules set filetype=javascript
  autocmd BufNewFile,BufRead *.mdc set filetype=markdown
augroup END

" バイナリファイルを開く場合
augroup fileTypeBinary
  autocmd!
  autocmd BufReadPre *.bin let &bin=1
  autocmd BufReadPost *.bin if &bin | %!xxd
  autocmd BufReadPost *.bin set ft=xxd | endif
  autocmd BufWritePre *.bin if &bin | %!xxd -r
  autocmd BufWritePre *.bin endif
  autocmd BufWritePost *.bin if &bin | %!xxd
  autocmd BufWritePost *.bin set nomod | endif
augroup END

" 設定ファイル関連のコマンド
command! Reload source $HOME/dotfiles/vimrc
command! Config edit $HOME/dotfiles/vimrc
command! PlugUpdate call dein#update()
command! PlugRecache call dein#recache_runtimepath()

" 新規ファイルの場合はインサートモード
autocmd VimEnter * if argc() == 0 | startinsert | endif

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
if has('win32') || has('win64')
  " ubuntuをpowershellに変更可能未指定の場合cmd.exeが起動する
  noremap <silent> <leader>t :terminal ++close ++curwin ubuntu<CR>
else
  noremap <silent> <leader>t :terminal<CR>
endif

tnoremap <silent> <C-l> <C-W>N
tnoremap <silent> <C-n> <DOWN>
tnoremap <silent> <C-p> <UP>

" 文字置換
nnoremap <leader>r "zyiw:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>
vnoremap <leader>r "zy:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>

" 範囲選択文字置換
vnoremap <leader>R :s///g<Left><Left><Left>

" 計算
nnoremap <silent> <leader>c :call setline(".",eval(getline(".")))<CR>
vnoremap <silent> <leader>c :!awk '{sum += $1} END {print sum}'<CR>

" カウント
vnoremap <silent> <leader>n :s/^/\=printf("%d", line(".") - line("'<") + 1)/<CR>

" 行の折返し変更
noremap <silent> <leader>wb :set wrap<CR>
noremap <silent> <leader>ww :set nowrap<CR>

" 文字コードをUTF-8にする
nnoremap <silent> <leader>utf :set ff=unix<CR>:set fileencoding=utf-8<CR>:set fenc=utf-8 bomb<CR>

" キーワードをgrep
nnoremap <silent> <leader>* "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>
vnoremap <silent> <leader>* "zy:let @/ = @z<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>

" キーワードが含まれる行を削除
nnoremap <leader>d "zyiw:let @/ = @z<CR>:set hlsearch<CR>:g/<C-r>//d<Left><Left>
vnoremap <leader>d "zy:let @/ = @z<CR>:set hlsearch<CR>:g/<C-r>//d<Left><Left>

" マクロの記録・実行
nnoremap <leader>M qz
nnoremap <leader>m @z

" コマンド履歴
noremap <silent> <leader>kk :<C-F>

function! GrepGitFiles(keyword)
  let l:ex = '*.' . expand('%:e')
  if l:ex == '*.'
    let l:ex = expand('%')
  endif

  " Cache git status check for current directory
  let l:git_dir = expand('%:p:h')
  let l:cache_key = 'git_status_' . substitute(l:git_dir, '[^a-zA-Z0-9]', '_', 'g')

  if !exists('g:' . l:cache_key) || (localtime() - get(g:, l:cache_key . '_time', 0)) > 30
    let l:is_git = system('git -C ' . shellescape(l:git_dir) . ' rev-parse --git-dir 2>/dev/null')
    let g:[l:cache_key] = !v:shell_error
    let g:[l:cache_key . '_time'] = localtime()
  endif

  if g:[l:cache_key]
    exe ':vimgrep /' . a:keyword . '/ `git ls-files ' . shellescape(expand('%:p:h')) . '`'
  else
    exe ':vimgrep /' . a:keyword . '/ **/' . l:ex
  endif
endfunction
