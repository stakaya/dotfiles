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
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:/opt/homebrew/bin:$PATH

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

zle -N git_checkout _git_checkout
zle -N jump_directory _jump_directory

# Keybind
bindkey -v
bindkey "jj" vi-cmd-mode
bindkey ";;" end-of-line
bindkey "kk" history-incremental-search-backward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey 'jd' jump_directory
bindkey 'gc' git_checkout

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# vim でCtrl Keyが効かないのを修整
stty stop undef
stty start undef

# checkout git branch
function _git_checkout() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# selected directory
function _jump_directory() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

