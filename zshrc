# Zsh設定ファイル
# 参考: https://github.com/zdharma-continuum/zinit
# 参考: https://zsh.sourceforge.io/

# 環境変数設定
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:/opt/homebrew/bin:$PATH

# エディタ設定
export EDITOR="vim"

# Node.js
export NVM_DIR="$HOME/.nvm"

# rbenv（Ruby環境管理）の遅延初期化（起動時間改善）
[[ -d ~/.rbenv ]] && {
  export PATH=${HOME}/.rbenv/bin:${PATH}
  # 必要時のみrbenvを初期化（遅延読み込み）
  rbenv() {
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
}

# fzf設定オプション
# ripgrepを使用してファイル検索を高速化
export FZF_DEFAULT_COMMAND='rg --no-messages --files --hidden --follow --glob "!**/.git/*"'

# Ctrl+Tでのファイル検索設定
export FZF_CTRL_T_COMMAND='rg --no-messages --files --hidden --follow --glob "!.git/*"'

# batを使用したファイルプレビュー設定
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header --line-range :100 {}"'

### Zinitプラグインマネージャーの自動インストール
# Zinitが未インストールの場合は自動的にダウンロード・セットアップ
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

# Zinitの初期化
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zshプラグインの読み込み（起動時間改善のためturboモード使用）
# 参考: https://github.com/zsh-users
zinit wait lucid for \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zdharma/fast-syntax-highlighting \
  rupa/z

# z（ディレクトリジャンプツール）の初期化
# 参考: https://github.com/rupa/z
[ -f ~/z/z.sh ] && source ~/z/z.sh

# fzf（ファジーファインダー）の初期化
# 参考: https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# エイリアス設定ファイルの読み込み
# 開発ツール、Git、一般コマンドのエイリアスを一括読み込み
for alias_file in $HOME/dotfiles/zsh/aliases/*.zsh; do
  source $alias_file
done

# 関数設定ファイルの読み込み
for function_file in $HOME/dotfiles/zsh/functions/*.zsh; do
  source $function_file
done

# カスタムウィジェットの登録
# fzfを使用したインタラクティブなGit操作とスペースキー機能
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
bindkey 'Ga' git_add
bindkey 'Gs' git_switch
bindkey 'Gf' git_fetch
bindkey 'kk' fzf-history-widget

# vim でCtrl Keyが効かないのを修整
stty stop undef
stty start undef

# prompt
eval "$(starship init zsh)"

# carapace
autoload -U compinit && compinit
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

# OpenClaw Completion
[ -f "/Users/stakaya/.openclaw/completions/openclaw.zsh" ] && source "/Users/stakaya/.openclaw/completions/openclaw.zsh"
