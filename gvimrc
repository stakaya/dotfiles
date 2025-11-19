" GVim（GUI Vim）設定ファイル
" 参考: https://vim-jp.org/vimdoc-ja/gui.html

" 基本表示設定
set linespace=2  " 行間を2ピクセルに設定
set notitle      " ウィンドウタイトルを設定しない

" OS別フォント・表示設定
if has('mac')
  " macOS環境設定
  if !exists("g:neovide")
    set guifontwide=Menlo:h14      " 全角文字用フォント
    set guifont=Menlo\ Regular:h14 " 半角文字用フォント
  endif

  " Command+[ で前の位置、Command+] で次の位置に移動
  nnoremap <D-[> g;
  nnoremap <D-]> g,
elseif has('win32') || has('win64')
  " Windows環境設定
  set directory=C:\WINDOWS\Temp             " スワップファイル保存先
  set renderoptions=type:directx            " DirectXレンダリング使用
  set ambiwidth=double                      " 曖昧幅文字を全角扱い
  set guifont=Consolas:h12                  " 半角文字用フォント
  set guifontwide=UD_デジタル_教科書体_N:h1 " 全角文字用フォント
endif

" Unix系OSでの自動クリップボード機能を抑制
" ビジュアルモードで選択した文字列の自動クリップボード登録を無効化
if !has('unix')
  set guioptions-=a
endif

" タブラベル設定
" %M: 変更フラグ、%t: ファイル名
if !exists("g:neovide")
  set guitablabel=%M%t
endif

" GUI要素の非表示設定
set guioptions-=T  " ツールバーを非表示
set guioptions-=m  " メニューバーを非表示
set guioptions-=r  " 右スクロールバーを非表示
set guioptions-=R  " 右スクロールバーを非表示（分割時）
set guioptions-=l  " 左スクロールバーを非表示
set guioptions-=L  " 左スクロールバーを非表示（分割時）
set guioptions-=b  " 下部スクロールバーを非表示

" Windows環境でのIME状態別カーソル色設定
if has('xim') || has('multi_byte_ime')
  highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
  highlight CursorIM guifg=NONE guibg=#ecbcbc
endif

" IME自動制御設定
" 挿入モード終了時にIMEを自動的にオフにする
if exists("g:neovide")
  augroup InsModeAu
    autocmd!
    autocmd InsertEnter * let g:neovide_input_ime = v:true
    autocmd InsertLeave * let g:neovide_input_ime = v:false
  augroup END
else
  augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
    autocmd InsertEnter,InsertLeave * set iminsert=0
  augroup END
endif

" タブ移動キーバインド
noremap <C-S-Tab> :tabprev<CR>
noremap <C-Tab> :tabnext<CR>
