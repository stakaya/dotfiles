# Tmux with Alacritty
if [[ -n "$ALACRITTY_WINDOW_ID" && ! -n $TMUX && $- == *l* ]]; then
	# get the IDs
	ID="`tmux list-sessions`"
	if [[ -z "$ID" ]]; then
		tmux new-session
	fi
	create_new_session="Create New Session"
	ID="$ID\n${create_new_session}:"
	ID="`echo $ID | fzf | cut -d: -f1`"
	if [[ "$ID" = "${create_new_session}" ]]; then
		tmux new-session
	elif [[ -n "$ID" ]]; then
		tmux attach-session -t "$ID"
	else
		:  # Start terminal normally
	fi
fi

# Zsh-completions
if [[ -e ~/.zsh/zsh-completions ]]; then
	fpath=(~/.zsh/zsh-completions $fpath)

	autoload -U compinit; compinit -u
	zstyle ':completion:*:sudo:*' matcher-list 'm:{a-z}={A-Z}' menu select=1 \
		command-path /usr/local/sbin /usr/local/bin \
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
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:/opt/homebrew/bin:$PATH
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!**/.git/*"'
export FZF_DEFAULT_OPTS="--height 40% --reverse --border=sharp --margin=0,1"
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'

# Alias
alias apkcheck='jarsigner -verify -verbose -certs $1'
alias brewclean='brew cleanup && brew update && brew upgrade --cask'
alias gitreset='git fetch --all && git reset --hard origin/main'
alias indocker='docker exec -it `docker ps -a -f status=running --format "{{.Names}}" | fzf` sh'
alias pip='pip3'
alias python='python3'
alias search='find ./ -type f -not -path "*/.git/*" | xargs grep --no-messages $1 --color'
alias tmux='tmux -u -2'
alias vi='nvim'
alias weather='curl -H "Accept-Language: ja" wttr.in/tokyo'
alias -s {md,markdown,txt,conf,toml,json,yml,yaml}=nvim
alias -s {gz,tgz,zip,bz2,tar}=extract

zle -N git_checkout
zle -N space_widget
zle -N fzf-cd-widget 

# Keybind
bindkey -v
bindkey "jj" vi-cmd-mode
bindkey ";;" end-of-line
bindkey "hh" history-incremental-search-backward
bindkey 'ff' fzf-file-widget 
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey 'gc' git_checkout
bindkey ' ' space_widget

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim でCtrl Keyが効かないのを修整
stty stop undef
stty start undef

# checkout git branch
function git_checkout() {
	local branches branch
	branches=$(git branch -vv) &&
		branch=$(echo "$branches" | fzf +m) &&
		git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function space_widget() {
	# when inptting spack key it changing directory
	if [[ "${BUFFER}" == " " ]]; then
		fzf-cd-widget 
   	else
   		zle self-insert
	fi
}

function extract() {
	case $1 in
		*.tar.gz|*.tgz) tar xzvf $1;;
		*.zip) unzip $1;;
		*.tar.bz2|*.tbz) tar xjvf $1;;
		*.gz) gzip -d $1;;
		*.bz2) bzip2 -dc $1;;
		*.tar) tar xvf $1;;
	esac
}
