# 開発ツール用エイリアス設定
# 参考: https://docs.docker.com/
# 参考: https://brew.sh/

# Android APKファイルの署名検証
# 参考: https://developer.android.com/studio/command-line/jarsigner
alias apkcheck='jarsigner -verify -verbose -certs $1'

# Homebrewの一括メンテナンス
# クリーンアップ、更新、アップグレードを順次実行
alias brewclean='brew cleanup && brew update && brew upgrade && brew upgrade --cask'

# 実行中Dockerコンテナへの対話的接続
# fzfで選択したコンテナにシェルで接続
alias indocker='docker exec -it `docker ps -a -f status=running --format "{{.Names}}" | fzf` sh'

# tmux起動設定
# UTF-8サポート（-u）と256色対応（-2）を有効化
alias tmux='tmux -u -2'   