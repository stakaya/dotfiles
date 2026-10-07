#!/usr/bin/env bash
# 共通 AGENTS.md を各エージェントの「ホーム側」へ配布し、
# プロジェクト側には追記用の薄いファイルだけ置く
set -euo pipefail

SOURCE="${1:-}"
ROOT="${2:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STUB="${SCRIPT_DIR}/PROJECT.stub.md"

usage() {
  cat <<'USAGE'
使い方:
  ./distribute-agents-md.sh [元の共通AGENTS.md] [プロジェクトディレクトリ]

共通ルール（ホーム）:
  Claude Code  → ~/.claude/rules/AGENTS.md
  Codex        → ~/.codex/AGENTS.md
  Grok Build   → ~/.grok/AGENTS.md

プロジェクト固有（追記用・未作成ならスタブを置く）:
  Claude Code/Codex/Cursor/Antigravity → <project>/AGENTS.md
  Copilot      → <project>/.github/copilot-instructions.md

既存のプロジェクトファイルは上書きしない（共通はホームだけ更新）。
Claude Code は既存の CLAUDE.md / CLAUDE.local.md があると、
標準設定ではプロジェクトの AGENTS.md を読みません。
両方読むには Project instructions を claude-md-and-agents-md に設定してください。
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ -z "$SOURCE" ]]; then
  if [[ -f "./AGENTS.md" ]]; then
    SOURCE="./AGENTS.md"
  elif [[ -f "$SCRIPT_DIR/AGENTS.md" ]]; then
    SOURCE="$SCRIPT_DIR/AGENTS.md"
  else
    echo "エラー: 元ファイルが見つかりません。AGENTS.md のパスを指定してください。" >&2
    usage
    exit 1
  fi
fi

if [[ ! -f "$SOURCE" ]]; then
  echo "エラー: 元ファイルがありません: $SOURCE" >&2
  exit 1
fi

ROOT="$(cd "$ROOT" && pwd)"
SOURCE="$(cd "$(dirname "$SOURCE")" && pwd)/$(basename "$SOURCE")"

copy_to() {
  local dest="$1"
  local dir
  dir="$(dirname "$dest")"
  mkdir -p "$dir"
  cp "$SOURCE" "$dest"
  echo "共通を書いた: $dest"
}

# 未作成のときだけスタブを置く（既存のプロジェクト固有は守る）
place_stub() {
  local dest="$1"
  if [[ -e "$dest" ]]; then
    echo "既存のためスキップ（プロジェクト固有）: $dest"
    return 0
  fi
  local dir
  dir="$(dirname "$dest")"
  mkdir -p "$dir"
  if [[ -f "$STUB" ]]; then
    cp "$STUB" "$dest"
  else
    printf '# プロジェクト固有ルール\n\n（このリポジトリだけの設定を追記）\n' > "$dest"
  fi
  echo "追記用スタブを置いた: $dest"
}

# --- 共通（ホーム） ---
copy_to "${HOME}/.claude/rules/AGENTS.md"
copy_to "${HOME}/.codex/AGENTS.md"
copy_to "${HOME}/.grok/AGENTS.md"

# --- プロジェクト固有（追記用） ---
place_stub "$ROOT/AGENTS.md"
place_stub "$ROOT/.github/copilot-instructions.md"

if [[ -f "$ROOT/CLAUDE.md" || -f "$ROOT/CLAUDE.local.md" || -f "$ROOT/.claude/CLAUDE.md" ]]; then
  echo "注意: Claude Code は既存の CLAUDE.md があると標準設定では AGENTS.md を読みません。" >&2
  echo "      両方読むには Project instructions を claude-md-and-agents-md に設定してください。" >&2
fi

echo
echo "配布完了。"
echo "共通:"
echo "  Claude Code → ~/.claude/rules/AGENTS.md"
echo "  Codex       → ~/.codex/AGENTS.md"
echo "  Grok Build  → ~/.grok/AGENTS.md"
echo "プロジェクト固有（既存は未上書き）:"
echo "  $ROOT/AGENTS.md"
echo "  $ROOT/.github/copilot-instructions.md"
echo
echo "元ファイル: $SOURCE"
echo "プロジェクト: $ROOT"
