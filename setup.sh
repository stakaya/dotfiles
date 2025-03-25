#!/bin/sh
set -e
cd ~

if [ ! -f /usr/local/bin/brew ]
	then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		echo "Homebrew already installed."
fi

if [ ! -d ~/dotfiles ]
	then
		echo "Cloning dotfiles..."
		git clone https://github.com/stakaya/dotfiles.git
	else
		echo "dotfiles already cloned."
fi

cd dotfiles

if [ -f /usr/local/bin/brew ]
    echo "Installing software & library..."
    brew bundle -v --file=./apps/Brewfile
fi

echo "Setup zsh."
zsh -f setup_shell.sh && echo "Done."

echo "Setup vim."
bash -f setup_app.sh && echo "Done."

if [ -f /usr/bin/defaults ]
	then
		echo "Settings for Mac"

        # 拡張子表示
        defaults write -g AppleShowAllExtensions -bool true

        # キーリピート
        defaults write -g InitialKeyRepeat -int 15
        defaults write -g KeyRepeat -int 2

        # クラッシュリポート
        defaults write -g NSAutomaticCapitalizationEnabled -bool false
        defaults write com.apple.CrashReporter DialogType -string "none"

        # ウインドウアニメーション
        defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

        # ツールチップの表示
        defaults write -g NSInitialToolTipDelay -integer 0

        # ウインドウリサイズ
        defaults write -g NSWindowResizeTime 0.1

        # サファリの開発メニュー
        defaults write -g WebKitDeveloperExtras -bool true

        # Finderに終了メニュー追加
        defaults write com.apple.Finder QuitMenuItem -bool true

        # ダウンロードしたファイルの警告
        defaults write com.apple.LaunchServices LSQuarantine -bool false

        # 充電音
        defaults write com.apple.PowerChime ChimeOnNoHardware -bool true

        # .DS_Store
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
        defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

        # dock
        defaults write com.apple.dock autohide -bool true
        defaults write com.apple.dock autohide-delay -float 0

        # ライブラリの表示
        chflags nohidden ~/Library

        # ネットワークの設定
        networksetup -SetDNSServers Wi-Fi 8.8.8.8 8.8.4.4
        networksetup -SetV6Off Wi-Fi

        # 起動音無効
        sudo nvram SystemAudioVolume=" "
fi

