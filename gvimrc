" ユーザ設定を保存
let s:cpo_save=&cpo
set linespace=2
set cpo&vim

" OS毎の設定
if has("mac")
	set guifontwide=Menlo:h12
	set guifont=Menlo\ Regular:h12
	nnoremap <D-[> g;
	nnoremap <D-]> g,
elseif has("win32") || has("win64")
	set directory=C:\WINDOWS\Temp
	set guifont=Consolas:h12:cSHIFTJIS
endif

" Unix系のOSでヴィジュアルモードで反転させた文字列が
" 自動的にクリップボードに入るのを抑止する
if !has('unix')
  set guioptions-=a
endif

" ラベル設定
set guitablabel=%M%t        

" アイコン非表示
set guioptions-=T

" メニュー非表示
set guioptions-=m

" ユーザ設定を復元
let &cpo = s:cpo_save
unlet s:cpo_save

" IME状態に応じたカーソル色を設定(for Windows)
if has('multi_byte_ime')
  highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
  highlight CursorIM guifg=NONE guibg=#ecbcbc
endif

" インサートモードから抜ける時、IMEをOFFにする
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

