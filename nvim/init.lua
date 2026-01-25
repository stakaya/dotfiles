-- Neovim設定ファイル
-- 参考: https://neovim.io/
-- 参考: https://github.com/neovim/neovim

if vim.g.vscode then
  -- VSCode Neovim拡張使用時
  require('keymaps')
else
  -- Lua設定を読み込み
  require('init')
end
