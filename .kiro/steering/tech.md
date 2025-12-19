# 技術スタック

## コア技術

- **シェル**: zinitプラグインマネージャー付きZsh
- **テキストエディタ**: dein.vimプラグインマネージャー付きVim 8+とNeovim
- **ターミナル**: tmuxマルチプレクサ付きAlacritty
- **プロンプト**: Starship（クロスシェルプロンプト）
- **パッケージマネージャー**: Homebrew（macOS/Linux）
- **バージョン管理**: git-lfs付きGit

## 主要ツールとユーティリティ

- **検索/ファイル検索**: ripgrep (rg)、fd、fzf（ファジーファインダー）
- **ファイル表示**: bat（シンタックスハイライト付きcat代替）
- **ファイル管理**: vifm（Vimライクなファイルマネージャー）
- **Git UI**: lazygit（git用ターミナルUI）
- **JSON処理**: jq
- **コンパイラ**: gcc、OpenJDK

## 開発ツール

- **IDE**: IntelliJ IDEA、Visual Studio Code
- **コンテナ**: Docker
- **ブラウザ**: Brave Browser
- **コミュニケーション**: Slack

## 言語サポート

- Python 3（debugpy、pylance付き）
- TypeScript/JavaScript（nodebrew経由のNode.js）
- Ruby（rbenv経由）
- Dart/Flutter
- PHP（xdebug付き）
- Java（OpenJDK）
- Kotlin、Svelte

## よく使うコマンド

### インストール
```bash
# フルセットアップ（リポジトリのクローン、Homebrewとアプリのインストール、シンボリックリンク作成）
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/stakaya/dotfiles/master/setup.sh)"

# シェルセットアップのみ
zsh -f setup_shell.sh

# アプリケーション設定セットアップのみ
zsh -f setup_app.sh

# Homebrewパッケージのインストール
brew bundle -v --file=./apps/Brewfile
```

### Vim/Neovim
```vim
:Reload          " vimrc設定を再読み込み
:Config          " vimrc設定を編集
:PlugUpdate      " dein.vim経由で全プラグインを更新
:PlugRecache     " プラグインのランタイムパスを再キャッシュ
```

### Zsh
```bash
zinit self-update  # zinitプラグインマネージャーを更新
source ~/.zshrc    # zsh設定を再読み込み
```

## 設定ファイル

- Vim: `vimrc`、`vimrc.keymap`、`gvimrc`、`ideavimrc`
- Neovim: `nvim/init.vim`
- Zsh: `zshrc`、`zsh/aliases/*.zsh`、`zsh/functions/*.zsh`
- Tmux: `tmux.conf`
- Alacritty: `alacritty/alacritty.toml`
- Starship: `starship.toml`
- Git: `git/ignore`（グローバルgitignore）
- Vimプラグイン: `vim/plugins/plugins.toml`、`vim/plugins/plugins_lazy.toml`

## プラグイン管理

### Vim（dein.vim）
- プラグインはTOMLファイルで定義
- パフォーマンス向上のための遅延読み込みをサポート
- 未使用プラグインの自動クリーンアップ（1日1回チェック）

### Zsh（zinit）
- 高速起動のためのターボモード
- 重いツール（rbenv）の遅延読み込み
- 初回実行時の自動インストール
