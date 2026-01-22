-- Neovim Lua設定ファイル
-- vimrcからの移行版

-- GUI設定を読み込み（GUIクライアント用）
-- UIEnterイベントでGUIを検出してginit.luaを読み込む
vim.api.nvim_create_autocmd('UIEnter', {
  once = true,
  callback = function()
    local ui = vim.api.nvim_list_uis()[1]
    if ui and ui.chan > 0 then
        vim.cmd('runtime ginit.lua')
    end
  end,
})

-- 基本設定を読み込み
require('options')

-- キーマッピングを読み込み
require('keymaps')

-- lazy.nvim プラグインマネージャー設定
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- プラグイン設定をlua/plugins/ディレクトリから読み込み
  { import = 'plugins' },
}, {
  install = {
    colorscheme = { 'darcula', 'habamax' },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- プラグイン管理コマンド
vim.api.nvim_create_user_command('PlugUpdate', function()
  require('lazy').sync()
end, {})
