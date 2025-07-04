# Performance monitoring (remove after testing)
if [[ -n "$ZSH_STARTUP_TIME" ]]; then
  zmodload zsh/datetime
  setopt PROMPT_SUBST
  PS4='+$EPOCHREALTIME %N:%i> '
  exec 3>&2 2>$ZSH_STARTUP_TIME
  setopt XTRACE
fi


# Performance monitoring (remove after testing)
if [[ -n "$ZSH_STARTUP_TIME" ]]; then
  zmodload zsh/datetime
  setopt PROMPT_SUBST
  PS4='+$EPOCHREALTIME %N:%i> '
  exec 3>&2 2>$ZSH_STARTUP_TIME
  setopt XTRACE
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

# load zsh plugin with turbo mode for faster startup
zinit wait lucid for \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zdharma/fast-syntax-highlighting \
  rupa/z

# Environment
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:/opt/homebrew/bin:$PATH

# Only initialize rbenv if ruby files are commonly used
[[ -d ~/.rbenv ]] && {
  export PATH=${HOME}/.rbenv/bin:${PATH}
  # Lazy load rbenv - only initialize when needed
  rbenv() {
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
}

# jump around
[ -f ~/z/z.sh ] && source ~/z/z.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fzf option
export FZF_DEFAULT_COMMAND='rg --no-messages --files --hidden --follow --glob "!**/.git/*"'
export FZF_DEFAULT_OPTS='--preview-window=border-none --no-scrollbar --height 40% --color=fg:#d0d0d0,bg:#121212,hl:#5f87af --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
export FZF_CTRL_T_COMMAND='rg --no-messages --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview-window=+8,border-none --preview "bat --color=always --style=header --line-range :100 {}"'

# Tmux with Alacritty - optimized with caching
if [[ -n "$ALACRITTY_WINDOW_ID" && ! -n $TMUX && $- == *l* ]]; then
	# Cache tmux sessions for 5 seconds to avoid repeated calls
	local cache_file="/tmp/tmux_sessions_$$"
	local cache_time=5
	
	if [[ ! -f "$cache_file" ]] || [[ $(($(date +%s) - $(stat -c %Y "$cache_file" 2>/dev/null || echo 0))) -gt $cache_time ]]; then
		tmux list-sessions 2>/dev/null > "$cache_file"
	fi
	
	ID="$(cat "$cache_file" 2>/dev/null)"
	if [[ -z "$ID" ]]; then
		tmux new-session
	else
		create_new_session="Create New Session"
		ID="$ID\n${create_new_session}:"
		ID="$(echo $ID | fzf | cut -d: -f1)"
		if [[ "$ID" = "${create_new_session}" ]]; then
			tmux new-session
		elif [[ -n "$ID" ]]; then
			tmux attach-session -t "$ID"
		fi
	fi
fi

# Load aliases
for alias_file in $HOME/dotfiles/zsh/aliases/*.zsh; do
  source $alias_file
done

zle -N git_add
zle -N git_fetch
zle -N git_switch
zle -N space_widget

# Keybind
bindkey -v
bindkey ' '  space_widget
bindkey ";;" end-of-line
bindkey "jj" vi-cmd-mode
bindkey '^N' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward
bindkey 'ga' git_add
bindkey 'gs' git_switch
bindkey 'gf' git_fetch
bindkey 'kk' fzf-history-widget

# vim でCtrl Keyが効かないのを修整
stty stop undef
stty start undef

# prompt
eval "$(starship init zsh)"

function git_switch() {
  local branches branch
  branches=$(git branch -vv) && \
    branch=$(echo "$branches" | fzf +m) && \
    git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function git_fetch() {
  local branches branch
  branches=$(git branch -vv -r) && \
    branch=$(echo "$branches" | fzf +m) && \
    git fetch $(echo "$branch" | awk '{print $1}' | sed "s/\// /")
}

function git_add() {
  local out q n addfiles
  while out=$(git status --short | awk '{if (substr($0,2,1) !~ / /) print $2}' | fzf-tmux --multi --exit-0 --expect=ctrl-d);
  do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

function space_widget() {
  # when inptting spack key it changing directory
  if [[ "${BUFFER}" == " " ]]; then
    fzf-cd-widget
  elif [[ "${BUFFER}" == "vi " || "${BUFFER}" == "vim " ]]; then
    fzf-file-widget
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
