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

# iOS開発用エイリアス
alias ioslist='xcrun simctl list devices'
alias iosclean='xcrun simctl delete unavailable'
alias iosreset='killall Simulator 2>/dev/null; \
killall -9 com.apple.CoreSimulator.CoreSimulatorService 2>/dev/null; \
xcrun simctl delete unavailable'

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

# AWS MFA
# security add-generic-password -a "$USER" -s "aws-mfa-secret" -w "あなたのMFAシークレットキー"
# security add-generic-password -a "$USER" -s "aws-mfa-arn" -w "arn:aws:iam::123456789012:mfa/あなたのデバイス名"
alias awsmfa='awsmfa \
--serial-number "$(security find-generic-password -a "$USER" -s "aws-mfa-arn" -w)" \
"$(oathtool --totp --base32 "$(security find-generic-password -a "$USER" -s "aws-mfa-secret" -w)")"'

# codex
alias codexl='CODEX_OSS_BASE_URL=http://127.0.0.1:11434/v1 codex --oss --local-provider ollama --model qwen3.8:27b-fast'

# Qwen3.8-27B & pi エージェント一括起動環境 (tmux画面分割)
# 左ペイン: llama-server (127.0.0.1:9931)
# 右ペイン: pi エージェント (ヘルスチェック完了後に自動起動、プロンプト画面にフォーカス)
qwen-pi() {
    local session="qwen-pi"
    local model_dir="$HOME/models/qwen3.8-27b"
    local workdir="$PWD"
    local server_cmd="cd $model_dir && ./run-local.sh server; exec $SHELL"
    local pi_cmd="echo 'Waiting for llama-server (127.0.0.1:9931)...'; until curl --noproxy '*' -fsS http://127.0.0.1:9931/health >/dev/null 2>&1; do sleep 1; done; echo 'llama-server is ready!'; $model_dir/run-local.sh pi; exec $SHELL"

    if [ -n "$TMUX" ]; then
        tmux new-window -n "qwen-pi" -c "$model_dir" "$server_cmd"
        tmux split-window -h -c "$workdir" "$pi_cmd"
        tmux select-pane -t 1
    else
        if tmux has-session -t "$session" 2>/dev/null; then
            echo "Session $session already exists. Attaching..."
            tmux attach-session -t "$session"
        else
            tmux new-session -d -s "$session" -c "$model_dir" "$server_cmd"
            tmux split-window -h -t "$session" -c "$workdir" "$pi_cmd"
            tmux select-pane -t "$session:0.1"
            tmux attach-session -t "$session"
        fi
    fi
}
alias pil='qwen-pi'

