# 開発ツール用エイリアス設定

# Android開発用エイリアス
# 参考: https://developer.android.com/studio/command-line/jarsigner
alias adbinstall='find ./ -name *.apk | fzf | xargs adb install -r'
alias adblogcat='pidcat `adb shell pm list package | sed -e s/package:// | fzf`'
alias adbreset='adb kill-server; adb start-server'
alias adbscreencap='FILE=`date +"%Y%m%d%I%m%S"`.png && adb shell screencap -p /sdcard/$FILE && adb pull /sdcard/$FILE $HOME/Desktop/$FILE && adb shell rm /sdcard/$FILE && open $HOME/Desktop/$FILE'
alias adbuninstall='adb shell pm list package | sed -e s/package:// | fzf | xargs adb uninstall'
alias apkpull='adb shell pm list package -f | sed -e "s/package:\([^=]*\).*/\1/g" | fzf | xargs adb pull'
alias apkcheck='jarsigner -verify -verbose -certs $1'
alias adbdebug='cd $ANDROID_HOME/emulator && ./emulator -avd $1'

# Python仮想環境の作成と有効化
alias venv="python -m venv venv && source venv/bin/activate"
alias gvenv="python -m venv ~/.venvs/global && source ~/.venvs/bin/activate"
alias python="python3"
alias pip="pip3"

# Homebrewの一括メンテナンス
# クリーンアップ、更新、アップグレードを順次実行
# 参考: https://brew.sh/
alias brewclean='brew cleanup && brew update && brew upgrade && brew upgrade --cask'

# 実行中Dockerコンテナへの対話的接続
# fzfで選択したコンテナにシェルで接続
# 参考: https://docs.docker.com/
alias indocker='docker exec -it `docker ps -a -f status=running --format "{{.Names}}" | fzf` sh'

# tmux起動設定
# UTF-8サポート（-u）と256色対応（-2）を有効化
alias tmux='tmux -u -2'
