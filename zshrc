# Zsh-completions
if [[ -e ~/.zsh/zsh-completions ]]; then
	fpath=(~/.zsh/zsh-completions $fpath)

	autoload -U compinit; compinit -u 
	zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
		/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
		/usr/local/git/bin
fi

# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# zsh-autosuggestions
if [[ -s ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Environment
export LSCOLORS=gxfxcxdxbxGxDxabagacad

# Alias
alias brewupdate='brew update && brew cask upgrade'
alias vi='nvim'

# Keybind
bindkey -v

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
