# プロジェクト構造

## ルートディレクトリ

ルートにある設定ファイルは、セットアップ時に`~/.<ファイル名>`へシンボリックリンクされます：
- `zshrc` - メインZsh設定
- `vimrc` - メインVim設定
- `vimrc.keymap` - Vimキーバインド定義
- `gvimrc` - GUI Vim設定
- `ideavimrc` - IntelliJ IDEA Vimプラグイン設定
- `tmux.conf` - Tmux設定
- `starship.toml` - Starshipプロンプト設定

## セットアップスクリプト

- `setup.sh` - マスターインストールスクリプト（Homebrewのインストール、リポジトリのクローン、他のスクリプトの実行）
- `setup_shell.sh` - Zshとzinitのセットアップ
- `setup_app.sh` - 全設定ファイルのシンボリックリンク作成
- `setup_app.bat` - Windows専用セットアップ（レガシー）

## ディレクトリ構成

### `/zsh/`
モジュール化されたZsh設定：
- `aliases/` - カテゴリ別に整理されたコマンドエイリアス
  - `dev.zsh` - 開発ツールエイリアス
  - `general.zsh` - 一般コマンドエイリアス
  - `git.zsh` - Gitコマンドエイリアス
- `functions/` - カスタムシェル関数
  - `command.zsh` - コマンドユーティリティ
  - `git.zsh` - Gitヘルパー関数

### `/vim/`
Vim専用設定（`~/.vim/`へシンボリックリンク）：
- `plugins/` - プラグイン管理
  - `plugins.toml` - メインプラグイン（即座に読み込み）
  - `plugins_lazy.toml` - 遅延読み込みプラグイン
  - `repos/github.com/` - インストール済みプラグインリポジトリ
  - `cache_Vim` - プラグインキャッシュ
- `dict/` - 日本語入力用辞書ファイル（SKK-JISYO）

### `/nvim/`
Neovim設定（`~/.config/nvim/`へシンボリックリンク）：
- `init.vim` - Neovimエントリーポイント（vimrcを読み込み）
- `ginit.vim` - GUI Neovim設定
- `plugins/` - Neovimプラグインディレクトリ（vim構造をミラー）
- `dict/` - vim/dictへのシンボリックリンク

### `/alacritty/`
Alacrittyターミナル設定（`~/.config/alacritty/`へシンボリックリンク）：
- `alacritty.toml` - ターミナル設定、カラー、フォント、キーバインド

### `/git/`
Git設定（`~/.config/git/`へシンボリックリンク）：
- `ignore` - グローバルgitignoreパターン

### `/vifm/`
Vifmファイルマネージャー設定（`~/.vifm/`へシンボリックリンク）：
- `vifmrc` - メイン設定
- `colors/` - カラースキーム
- `scripts/` - カスタムスクリプト

### `/apps/`
アプリケーションインストールマニフェスト：
- `Brewfile` - Homebrewバンドルファイル（CLIツール、cask、VSCode拡張機能）
- `winget.json` - Windowsパッケージマネージャーマニフェスト

### `/doc/`
ドキュメント：
- `spec.ja.md` - 日本語仕様書/ドキュメント

### `/.specstory/`
Spec storyの履歴（AI対話ログ）：
- `history/` - タイムスタンプ付き対話記録

### `/.cursor/`
Cursor IDEルール：
- `rules/globals.mdc` - グローバルCursorルール
- `rules/dev-rules/` - 開発専用ルール

### `/.kiro/`
Kiro AIアシスタント設定：
- `steering/` - AIガイダンスドキュメント（このディレクトリ）

## シンボリックリンク戦略

セットアップ時に以下のシンボリックリンクを作成：
```
~/dotfiles/zshrc          → ~/.zshrc
~/dotfiles/vimrc          → ~/.vimrc
~/dotfiles/vim            → ~/.vim
~/dotfiles/nvim           → ~/.config/nvim
~/dotfiles/alacritty      → ~/.config/alacritty
~/dotfiles/git            → ~/.config/git
~/dotfiles/vifm           → ~/.vifm
~/dotfiles/tmux.conf      → ~/.tmux.conf
~/dotfiles/starship.toml  → ~/.config/starship.toml
```

## ファイル命名規則

- シェルスクリプト: `.sh`拡張子、実行可能
- Vimスクリプト: `.vim`拡張子
- Zshモジュール: `.zsh`拡張子
- 設定ファイル: 拡張子なし、またはフォーマット固有（`.toml`、`.conf`）
- ドキュメント: `.md`（Markdown）

## プラットフォーム固有の注意事項

- macOS: 主要ターゲット、Homebrewを使用、macOSシステムデフォルトを含む
- Linux: 副次的サポート、システムパッケージマネージャーを使用
- Windows（WSL）: 第三次サポート、クリップボードにclip.exeを使用
- tmux.confでのクロスプラットフォームクリップボード処理
- `uname -a`チェックによるプラットフォーム検出
