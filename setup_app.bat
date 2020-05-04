@set DOTFILES=%USERPROFILE%\dotfiles
for %%i in (vimrc, gvimrc, ideavimrc) do (
	if not exist "%USERPROFILE%\%%i" (
		mklink "%USERPROFILE%\_%%i" "%DOTFILES%\%%i"
	)
)

if not exist "%USERPROFILE%\vimfiles\plugins" (
	md "%USERPROFILE%\vimfiles\" 
	mklink /D "%USERPROFILE%\vimfiles\plugins" "%DOTFILES%\vim\plugins" 
	mklink "%USERPROFILE%\vimfiles\plugins\plugins.toml" "%DOTFILES%\vim\plugins\plugins.toml"
	mklink "%USERPROFILE%\vimfiles\plugins\plugins_lazy.toml" "%DOTFILES%\vim\plugins\plugins_lazy.toml"
   	git clone git://github.com/Shougo/dein.vim "%USERPROFILE%\vimfiles\plugins\dein.vim"
)

if not exist "%USERPROFILE%\.vim" (
	mklink /D "%USERPROFILE%\.vim" "%DOTFILES%\vim" 
)

if not exist "%LOCALAPPDATA%\nvim" (
	mklink /D "%LOCALAPPDATA%\nvim" "%DOTFILES%\nvim" 
)

if not exist "%APPDATA%\Vifm" (
	mklink /D "%APPDATA%\Vifm" "%DOTFILES%\vifm" 
)

if not exist "%USERPROFILE%\vimfiles\dict" (
	mklink /D "%USERPROFILE%\vimfiles\dict" "%DOTFILES%\vim\dict"
)

if not exist "%USERPROFILE%\.tmux.conf" (
	mklink "%USERPROFILE%\.tmux.conf" "%DOTFILES%\tmux.conf" 
)

@pause
