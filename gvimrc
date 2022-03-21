set linespace=2
set notitle

" OS毎の設定
if has('mac')
  set guifontwide=Menlo:h14
  set guifont=Menlo\ Regular:h14
  nnoremap <D-[> g;
  nnoremap <D-]> g,
elseif has('win32') || has('win64')
  set directory=C:\WINDOWS\Temp
  set renderoptions=type:directx
  set ambiwidth=double
  set guifont=Consolas:h12
  set guifontwide=UD_デジタル_教科書体_N-R:h12
endif

" Unix系のOSでヴィジュアルモードで反転させた文字列が
" 自動的にクリップボードに入るのを抑止する
if !has('unix')
  set guioptions-=a
endif

" ラベル設定
set guitablabel=%M%t

" メニュー・スクロールバー非表示
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

" IME状態に応じたカーソル色を設定(for Windows)
if has('xim') || has('multi_byte_ime')
  highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
  highlight CursorIM guifg=NONE guibg=#ecbcbc
endif

" インサートモードから抜ける時にIMEをOFFにする
augroup InsModeAu
  autocmd!
  autocmd InsertEnter,CmdwinEnter * set noimdisable
  autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

" CTRL-Tab でタブを移動
noremap <C-S-Tab> :tabprev<CR>
noremap <C-Tab> :tabnext<CR>
