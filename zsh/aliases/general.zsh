# 一般コマンド用エイリアス設定
# 参考: https://www.gnu.org/software/coreutils/

# ファイル一覧表示（色付き）
alias ls='ls --color'

# 東京の天気予報を日本語で取得
# 参考: https://wttr.in/
alias weather='curl -H "Accept-Language: ja" wttr.in/tokyo'

# プロジェクト内ファイル検索
# .gitディレクトリを除外してgrep検索を実行
alias look='find ./ -type f -not -path "*/.git/*" | xargs grep --no-messages $1 --color'

# サフィックスエイリアス設定
# ファイル拡張子に応じて自動的にアプリケーションを起動
alias -s {md,markdown,txt,conf,toml,json,yml,yaml}=vi  # テキストファイルはviで開く
alias -s {gz,tgz,zip,bz2,tar}=extract                  # アーカイブファイルは展開
