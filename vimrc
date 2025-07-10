" Vim設定ファイル
" 参考: https://vim-jp.org/
" 参考: https://github.com/vim-jp/vim-jp.github.io

" スペースキーをリーダーキーに設定
" リーダーキーは独自キーマップのプレフィックスとして使用
let g:mapleader = "\<space>"

" カスタマイズキーマップを読み込み
" 日本語キーボード対応やVimライクなキーバインドを設定
source $HOME/dotfiles/vimrc.keymap

" Neovim以外の場合の設定
if !has('nvim')
  " Vimのデフォルト設定を読み込み
  source $VIMRUNTIME/defaults.vim
  " クリップボード連携を有効化
  set clipboard=unnamed,autoselect
endif

" Vim起動時の初期設定
if has('vim_starting')
  " カーソル形状の設定（ターミナル用）
  let &t_SI .= "\e[6 q" " 挿入モード：縦棒カーソル
  let &t_EI .= "\e[2 q" " ノーマルモード：ブロックカーソル
  let &t_SR .= "\e[4 q" " 置換モード：下線カーソル

  " dein.vimプラグインマネージャーのパス設定
  if has('win32') || has('win64')
    set runtimepath+=$HOME\vimfiles\plugins\repos\github.com\Shougo\dein.vim
  else
    set runtimepath+=~/.vim/plugins/repos/github.com/Shougo/dein.vim/
  endif
endif

if has('win32') || has('win64')
  let s:plugin_config_dir = expand($HOME.'\vimfiles\plugins')
  let s:plugin_install_dir = s:plugin_config_dir

  " WindowsでPATHに$VIMが含まれていない時に
  " currentのexeを見つけ出せないので追加
  if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
  endif
else
  let s:plugin_config_dir = expand('~/.vim/plugins')
  if has('nvim')
    let s:plugin_install_dir = expand('~/.config/nvim/plugins')
  else
    let s:plugin_install_dir = expand('~/.vim/plugins')
  endif
endif

" プラグインの読み込み
" dein.vim プラグインマネージャーを使用
" 参考: https://github.com/Shougo/dein.vim
if dein#load_state(s:plugin_install_dir)
  call dein#begin(s:plugin_install_dir)
  call dein#load_toml(s:plugin_config_dir . '/plugins.toml', {'lazy': 0})
  call dein#load_toml(s:plugin_config_dir . '/plugins_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif

" 不要なプラグインの自動削除（起動時間改善のため1日1回のみチェック）
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

" True Color（24bit色）サポートを有効化
" 現代的なターミナルでの色表現を向上
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" ターミナルモードの色設定
" 背景：ダークグレー、文字：ライトグレー
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

" 基本設定
" 参考: https://vim-jp.org/vimdoc-ja/options.html

set ambiwidth=single   " 全角文字の幅を1文字分として扱う
set autoindent         " 新しい行で前の行のインデントを維持
set autowrite          " バッファ切り替え時に自動保存
set cursorline         " カーソル行をハイライト表示
set encoding=utf-8     " 内部文字エンコーディングをUTF-8に設定
                       " ファイル読み込み時の文字エンコーディング自動判定
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan
set fileformats=unix,dos,mac " 改行コードの自動判定順序
set formatoptions+=mMj " 日本語テキストの自動折り返し対応
set hlsearch           " 検索結果をハイライト表示
set ignorecase         " 検索時に大文字小文字を区別しない
set iminsert=0         " 挿入モード開始時のIME状態（オフ）
set imsearch=-1        " 検索時のIME状態（挿入モードと同じ）
set incsearch          " 検索文字入力中にリアルタイム検索
set laststatus=2       " ステータスラインを常に表示
set mouse=a            " 全モードでマウス操作を有効化
set nofoldenable       " コード折りたたみ機能を無効化
set nolist             " タブや改行などの制御文字を非表示
set noshowmode         " モード表示を無効化（ステータスラインで表示）
set noswapfile         " スワップファイルを作成しない
set nowrap             " 長い行の折り返し表示を無効化
set number             " 行番号を表示
set ruler              " カーソル位置（行・列）を常に表示
set shiftwidth=4       " 自動インデント時の幅
set showcmd            " 入力中のコマンドを画面右下に表示
set smartindent        " プログラミング言語に適したインデント
set splitbelow         " 水平分割時に新ウィンドウを下に表示
set tabstop=4          " タブ文字の表示幅
set vb t_vb=           " ビープ音を無効化（視覚ベルも無効）
set virtualedit=all    " 文字のない場所にもカーソル移動可能

" 外部ツール設定
" ripgrep（rg）が利用可能な場合はgrepコマンドを置き換え
" 参考: https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ステータスライン設定
" 文字エンコーディング、改行コード、カーソル位置を表示
set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l:%c

" カーソルライン表示の制御
" アクティブウィンドウでのみカーソル行をハイライト
augroup cursorLine
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" ファイルタイプ検出とプラグイン・インデント設定を有効化
filetype plugin indent on

" ファイルタイプ別設定
augroup fileTypeIndent
  autocmd!
  " テキストファイルとMarkdownは行の折り返しとタブ展開を有効
  autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap expandtab
  " Web系ファイルはインデント幅を2に設定
  autocmd BufNewFile,BufRead *.json,*.md,*.html,*.css,*.ts,*.js,*vimrc* setlocal tabstop=2 shiftwidth=2
  " プログラミング言語はC言語スタイルのインデントを適用
  autocmd BufNewFile,BufRead *.ts,*.js setlocal cindent expandtab shiftround
  " カスタムファイルタイプの設定
  autocmd BufNewFile,BufRead *.rules set filetype=javascript
  autocmd BufNewFile,BufRead *.mdc set filetype=markdown
augroup END

" バイナリファイル編集設定
" xxdコマンドを使用してバイナリファイルを16進数表示で編集
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

" カスタムコマンド定義設定ファイル関連のコマンド
command! Reload source $HOME/dotfiles/vimrc
command! Config edit $HOME/dotfiles/vimrc
command! PlugUpdate call dein#update()
command! PlugRecache call dein#recache_runtimepath()

" 自動動作設定
" 引数なしでVim起動時は挿入モードで開始
autocmd VimEnter * if argc() == 0 | startinsert | endif

" ファイル編集時にカレントディレクトリを自動変更
autocmd BufEnter * if isdirectory(expand('%:p:h')) | lcd %:p:h | endif

" make、grep実行後にQuickfixウィンドウを自動表示
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

" Git対応検索関数
" Gitリポジトリ内ではgit管理ファイルのみを検索対象とする
function! GrepGitFiles(keyword)
  let l:file_extension = '*.' . expand('%:e')
  if l:file_extension == '*.'
    let l:file_extension = expand('%')
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
    exe ':vimgrep /' . a:keyword . '/ **/' . l:file_extension
  endif
endfunction
