@set DOTFILES=%USERPROFILE%\dotfiles
for %%i in (vimrc, gvimrc, ideavimrc) do (
  if not exist %USERPROFILE%\%%i (
    mklink %USERPROFILE%\_%%i %DOTFILES%\%%i
  )
)

if not exist %USERPROFILE%\vimfiles (
  mklink /D %USERPROFILE%\vimfiles %USERPROFILE%\vim
)

if not exist %USERPROFILE%\vimfiles\plugins (
  md %USERPROFILE%\vimfiles\plugins & git clone git://github.com/Shougo/dein.vim %USERPROFILE%\vimfiles\plugins\dein.vim
)

@pause
