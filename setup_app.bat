@set DOTFILES=%USERPROFILE%\dotfiles
for %%i in (vimrc, gvimrc, ideavimrc) do (
	if not exist "%USERPROFILE%\%%i" (
		mklink "%USERPROFILE%\_%%i" "%DOTFILES%\%%i"
	)
)

if not exist "%USERPROFILE%\vimfiles\plugins" (
	md "%USERPROFILE%\vimfiles\"
	mklink /D "%USERPROFILE%\vimfiles\plugins" "%DOTFILES%\vim\plugins"
 	mkdir "%USERPROFILE%\vimfiles\plugins\repos\github.com\Shougo\dein.vim"
   	git clone https://github.com/Shougo/dein.vim.git "%USERPROFILE%\vimfiles\plugins\repos\github.com\Shougo\dein.vim"
)

if not exist "%LOCALAPPDATA%\nvim" (
	mklink /D "%LOCALAPPDATA%\nvim" "%DOTFILES%\nvim"
)

if not exist "%APPDATA%\Vifm" (
	mklink /D "%APPDATA%\Vifm" "%DOTFILES%\vifm"
)

if not exist "%USERPROFILE%\vimfiles\plugins" (
	mklink /D "%USERPROFILE%\vimfiles\plugins" "%DOTFILES%\vim\plugins"
)

if not exist "%USERPROFILE%\vimfiles\dict" (
	mklink /D "%USERPROFILE%\vimfiles\dict" "%DOTFILES%\vim\dict"
)

if not exist "%USERPROFILE%\.tmux.conf" (
	mklink "%USERPROFILE%\.tmux.conf" "%DOTFILES%\tmux.conf"
)

@pause
