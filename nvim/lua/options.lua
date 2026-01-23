-- Neovim基本設定
-- vimrcからの移行版

local opt = vim.opt
local g = vim.g

-- リーダーキー設定
g.mapleader = ' '
g.maplocalleader = ' '

-- クリップボード設定
opt.clipboard = 'unnamedplus'

-- 置換時のリアルタイムプレビュー
opt.inccommand = 'split'

-- Python3パス設定
g.python3_host_prog = vim.fn.expand("~/.venvs/global/bin/python")

vim.api.nvim_set_hl(0, "Terminal", {
  fg = "#bbbbbb",
  bg = "#2a2a2a",
})
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.g.terminal_color_0  = "#000000"
    vim.g.terminal_color_1  = "#fd6b67"
    vim.g.terminal_color_2  = "#097e00"
    vim.g.terminal_color_3  = "#ccca00"
    vim.g.terminal_color_4  = "#5496ef"
    vim.g.terminal_color_5  = "#fd75ff"
    vim.g.terminal_color_6  = "#39cbcc"
    vim.g.terminal_color_7  = "#bbbbbb"
    vim.g.terminal_color_8  = "#676767"
    vim.g.terminal_color_9  = "#fd8784"
    vim.g.terminal_color_10 = "#73f961"
    vim.g.terminal_color_11 = "#fefb00"
    vim.g.terminal_color_12 = "#7eaff4"
    vim.g.terminal_color_13 = "#fd9cff"
    vim.g.terminal_color_14 = "#6ed9d9"
    vim.g.terminal_color_15 = "#f1f1f1"
  end,
})

-- True Color（24bit色）サポート
opt.termguicolors = true

-- 文字エンコーディング設定
opt.encoding = 'utf-8'
opt.fileencodings = 'utf-8,iso-2022-jp,cp932,euc-jp,japan'
opt.fileformats = 'unix,dos,mac'

-- 全角文字の幅
opt.ambiwidth = 'single'

-- インデント設定
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4

-- 自動保存
opt.autowrite = true

-- カーソル行ハイライト
opt.cursorline = true

-- 日本語テキスト対応
opt.formatoptions:append('mMj')

-- 検索設定
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- IME設定
opt.iminsert = 0
opt.imsearch = -1

-- ステータスライン
opt.laststatus = 2

-- マウス操作
opt.mouse = 'a'

-- 折りたたみ無効化
opt.foldenable = false

-- 制御文字非表示
opt.list = false

-- モード表示無効化
opt.showmode = false

-- スワップファイル無効化
opt.swapfile = false

-- 折り返し表示無効化
opt.wrap = false

-- 行番号表示
opt.number = true

-- カーソル位置表示
opt.ruler = true

-- コマンド表示
opt.showcmd = true

-- 水平分割時に新ウィンドウを下に
opt.splitbelow = true

-- 垂直分割時に新ウィンドウを右に
opt.splitright = true

-- ビープ音無効化
opt.visualbell = true

-- 文字のない場所にもカーソル移動可能
opt.virtualedit = 'all'

-- ripgrepが利用可能な場合の設定
if vim.fn.executable('rg') == 1 then
  opt.grepprg = 'rg --vimgrep'
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- ステータスライン設定
opt.statusline = "%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%=%l:%c"

-- カーソルライン表示の制御
local cursorline_group = vim.api.nvim_create_augroup('cursorLine', { clear = true })
vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufRead' }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- ファイルタイプ検出
vim.cmd('filetype plugin indent on')

-- ファイルタイプ別設定
local filetype_group = vim.api.nvim_create_augroup('fileTypeIndent', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = filetype_group,
  pattern = { '*.txt', '*.md' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.expandtab = true
  end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = filetype_group,
  pattern = { '*.json', '*.md', '*.html', '*.css', '*.js', '*vimrc*' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = filetype_group,
  pattern = { '*.js' },
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.shiftround = true
  end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = filetype_group,
  pattern = '*.rules',
  callback = function()
    vim.bo.filetype = 'javascript'
  end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = filetype_group,
  pattern = '*.mdc',
  callback = function()
    vim.bo.filetype = 'markdown'
  end,
})

-- バイナリファイル編集設定
local binary_group = vim.api.nvim_create_augroup('fileTypeBinary', { clear = true })
vim.api.nvim_create_autocmd('BufReadPre', {
  group = binary_group,
  pattern = '*.bin',
  callback = function()
    vim.bo.binary = true
  end,
})
vim.api.nvim_create_autocmd('BufReadPost', {
  group = binary_group,
  pattern = '*.bin',
  callback = function()
    if vim.bo.binary then
      vim.cmd('%!xxd')
      vim.bo.filetype = 'xxd'
    end
  end,
})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = binary_group,
  pattern = '*.bin',
  callback = function()
    if vim.bo.binary then
      vim.cmd('%!xxd -r')
    end
  end,
})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = binary_group,
  pattern = '*.bin',
  callback = function()
    if vim.bo.binary then
      vim.cmd('%!xxd')
      vim.bo.modified = false
    end
  end,
})

-- カスタムコマンド定義
vim.api.nvim_create_user_command('Reload', function()
  vim.cmd('source $HOME/dotfiles/nvim/lua/init.lua')
end, {})
vim.api.nvim_create_user_command('Config', function()
  vim.cmd('edit $HOME/dotfiles/nvim/lua/init.lua')
end, {})

-- ファイル編集時にカレントディレクトリを自動変更
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local dir = vim.fn.expand('%:p:h')
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd('lcd ' .. dir)
    end
  end,
})

-- make、grep実行後にQuickfixウィンドウを自動表示
vim.api.nvim_create_autocmd('QuickfixCmdPost', {
  pattern = { 'make', 'grep', 'vimgrep' },
  callback = function()
    vim.cmd('copen')
  end,
})
