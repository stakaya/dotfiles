# Git操作用エイリアス設定
# 参考: https://git-scm.com/docs

# Gitリポジトリの完全リセット
# 全リモートブランチをフェッチしてmainブランチの最新状態にハードリセット
alias gitreset='git fetch --all && git reset --hard origin/main'   