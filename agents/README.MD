# エージェント共通ルールの配布

このディレクトリには、複数のコーディングエージェントで使う共通ルールと、それをホームディレクトリおよびプロジェクトへ配布するスクリプトがある。

## ファイル

| ファイル | 用途 |
| --- | --- |
| `AGENTS.md` | エージェント共通の作業・コミュニケーション・検証ルール |
| `PROJECT.stub.md` | プロジェクト固有のルールを書き足すためのひな形 |
| `distribute-agents-md.sh` | 共通ルールをホーム側へコピーし、プロジェクト側に追記用ファイルを配置するスクリプト |

## 使い方

リポジトリのルートから、共通ルールのファイルと適用先プロジェクトを指定して実行します。

```bash
bash ./agents/distribute-agents-md.sh ./agents/AGENTS.md /path/to/project
```

第1引数は配布元の共通 `AGENTS.md`、第2引数はプロジェクトのディレクトリです。第2引数を省略すると、カレントディレクトリがプロジェクトとして使われます。

```bash
# プロジェクトの AGENTS.md を配布元として、カレントディレクトリに適用
bash ./agents/distribute-agents-md.sh

# 配布元を省略して、指定プロジェクトに適用
bash ./agents/distribute-agents-md.sh "" /path/to/project
```

配布元を省略した場合は、カレントディレクトリの `AGENTS.md` を優先し、なければこのスクリプトと同じディレクトリの `AGENTS.md` を使います。実行方法を確認するには次を実行してください。

```bash
bash ./agents/distribute-agents-md.sh --help
```

## 配置先と上書き動作

スクリプトは共通ルールを次のホーム側ファイルへコピーします。これらは実行のたびに上書きされます。

- Claude Code: `~/.claude/rules/AGENTS.md`
- Codex: `~/.codex/AGENTS.md`
- Grok Build: `~/.grok/AGENTS.md`

プロジェクト側には次のファイルを配置します。既存ファイルがある場合は上書きせず、そのまま残します。

- `AGENTS.md`（Claude Code、Codex、Cursor、Antigravity 向け）
- `.github/copilot-instructions.md`（Copilot 向け）

新規作成するファイルには `PROJECT.stub.md` の内容が使われます。プロジェクト固有の設定は各ファイルに追記してください。

## 注意点

- ホーム側の共通ファイルは上書きされるため、実行前に配布元と適用先を確認してください。
- 配布元ファイルが見つからない場合、または指定したファイルが存在しない場合はエラーで終了します。
- Claude Code は既存の `CLAUDE.md`、`CLAUDE.local.md`、`.claude/CLAUDE.md` があると、標準設定ではプロジェクトの `AGENTS.md` を読みません。両方を読み込むには Project instructions を `claude-md-and-agents-md` に設定してください。
