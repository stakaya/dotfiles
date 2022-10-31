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
# export LSCOLORS=gxfxcxdxbxGxDxabagacad
export PATH=$HOME/.nodebrew/current/bin:/opt/homebrew/bin:$PATH

# Alias
alias vi='nvim'
alias pip='pip3'
alias python='python3'
alias gitreset='git fetch --all && git reset --hard origin/main'
alias brewclean='brew cleanup && brew update && brew upgrade --cask'
alias apkcheck='jarsigner -verify -verbose -certs $1'
alias search='find ./ -type f | xargs grep $1'
alias indocker='docker exec -it `docker ps -a -f status=running --format "{{.Names}}" | fzf` sh'

# Keybind
bindkey -v
bindkey "jj" vi-cmd-mode
bindkey ";;" end-of-line
bindkey "kk" history-incremental-search-backward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# vim でCtrl Keyが効かないのを修整
stty stop undef
stty start undef
