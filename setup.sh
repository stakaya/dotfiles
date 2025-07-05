#!/bin/zsh


set -e
cd ~

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrewをインストール中..."
    install_script=$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
    if [ $? -eq 0 ]; then
        /bin/bash -c "$install_script"
    else
        echo "Error: Failed to download Homebrew installation script." >&2
        exit 1
    fi
else
    echo "Homebrew は既にインストール済みです。"
fi

if [ ! -d ~/dotfiles ]
then
	echo "dotfilesをクローン中..."
	git clone https://github.com/stakaya/dotfiles.git
else
	echo "dotfiles は既にクローン済みです。"
fi

cd dotfiles
if command -v brew >/dev/null 2>&1; then
    echo "ソフトウェア・ライブラリをインストール中..."
    brew bundle -v --file=./apps/Brewfile
fi

echo "Zshをセットアップ中..."
zsh -f setup_shell.sh && echo "完了。"

echo "Vimをセットアップ中..."
zsh -f setup_app.sh && echo "完了。"

if [ -f /usr/bin/defaults ]
	then
		echo "macOS設定を適用中..."

        defaults write -g AppleShowAllExtensions -bool true

        defaults write -g InitialKeyRepeat -int 15  # リピート開始までの時間
        defaults write -g KeyRepeat -int 2          # リピート間隔

        defaults write -g NSAutomaticCapitalizationEnabled -bool false
        defaults write com.apple.CrashReporter DialogType -string "none"

        defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

        defaults write -g NSInitialToolTipDelay -integer 0

        defaults write -g NSWindowResizeTime 0.1

        defaults write -g WebKitDeveloperExtras -bool true

        # Finderに終了メニューを追加
        defaults write com.apple.Finder QuitMenuItem -bool true

        defaults write com.apple.LaunchServices LSQuarantine -bool false

        defaults write com.apple.PowerChime ChimeOnNoHardware -bool true

        # .DS_Storeファイルの作成を抑制
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # ネットワーク
        defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true      # USB

        defaults write com.apple.dock autohide -bool true      # 自動非表示
        defaults write com.apple.dock autohide-delay -float 0  # 表示遅延なし

        chflags nohidden ~/Library

        networksetup -SetDNSServers Wi-Fi 8.8.8.8 8.8.4.4  # Google DNS
        networksetup -SetV6Off Wi-Fi                        # IPv6無効化

        sudo nvram SystemAudioVolume=" "
fi

