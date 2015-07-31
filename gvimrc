" ユーザ設定を保存
let s:cpo_save=&cpo
set lsp=2
set cpo&vim

if has("mac")
	set guifontwide=Osaka:h12
	set guifont=Osaka-Mono:h14
	set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error

	if !exists("macvim_skip_cmd_opt_movement")
		no   <D-Left>       <Home>
		no!  <D-Left>       <Home>
		no   <M-Left>       <C-Left>
		no!  <M-Left>       <C-Left>

		no   <D-Right>      <End>
		no!  <D-Right>      <End>
		no   <M-Right>      <C-Right>
		no!  <M-Right>      <C-Right>

		no   <D-Up>         <C-Home>
		ino  <D-Up>         <C-Home>
		map  <M-Up>         {
		imap <M-Up>         <C-o>{

		no   <D-Down>       <C-End>
		ino  <D-Down>       <C-End>
		map  <M-Down>       }
		imap <M-Down>       <C-o>}

		imap <M-BS>         <C-w>
		imap <D-BS>         <C-u>
	endif

	if exists("macvim_hig_shift_movement")
		" Shift + special movement key (<S-Left>, etc.) and mouse starts insert mode
		set selectmode=mouse,key
		set keymodel=startsel,stopsel

		" HIG related shift + special movement key mappings
		nn   <S-D-Left>     <S-Home>
		vn   <S-D-Left>     <S-Home>
		ino  <S-D-Left>     <S-Home>
		nn   <S-M-Left>     <S-C-Left>
		vn   <S-M-Left>     <S-C-Left>
		ino  <S-M-Left>     <S-C-Left>

		nn   <S-D-Right>    <S-End>
		vn   <S-D-Right>    <S-End>
		ino  <S-D-Right>    <S-End>
		nn   <S-M-Right>    <S-C-Right>
		vn   <S-M-Right>    <S-C-Right>
		ino  <S-M-Right>    <S-C-Right>

		nn   <S-D-Up>       <S-C-Home>
		vn   <S-D-Up>       <S-C-Home>
		ino  <S-D-Up>       <S-C-Home>

		nn   <S-D-Down>     <S-C-End>
		vn   <S-D-Down>     <S-C-End>
		ino  <S-D-Down>     <S-C-End>
	endif
endif

if has("win32")
	set directory=C:\WINDOWS\Temp
	let s:using_font= 'Osaka' . "\x81\x7c\x93\x99\x95\x9d"
	let &guifont=s:using_font . ':h12:cSHIFTJIS'
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

" IME状態に応じたカーソル色を設定
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

