@set DOTFILES=%USERPROFILE%\dotfiles
for %%i in (vimrc, gvimrc) do (
  if not exist %USERPROFILE%\%%i (
    mklink %USERPROFILE%\_%%i %DOTFILES%\%%i
  )
)

if not exist %USERPROFILE%\vimfiles (
  mklink /D %USERPROFILE%\vimfiles %USERPROFILE%\vim
)

if not exist %USERPROFILE%\vimfiles\bundle (
  md %USERPROFILE%\vimfiles\bundle & git clone git://github.com/Shougo/neobundle.vim %USERPROFILE%\vimfiles\bundle\neobundle.vim
)

@pause
