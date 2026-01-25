---@diagnostic disable: undefined-global
-- Neovim GUI設定ファイル
-- gvimrcからの移行版
-- 参考: https://neovim.io/doc/user/gui.html
-- このファイルはGUI起動時に自動的に読み込まれます

local opt = vim.opt

-- 基本表示設定
opt.linespace = 2  -- 行間を2ピクセルに設定
opt.title = false  -- ウィンドウタイトルを設定しない

vim.api.nvim_set_hl(0, "Terminal", {
  fg = "#bbbbbb",
  bg = "#2a2a2a",
})

-- OS別フォント・表示設定
if vim.fn.has('mac') == 1 then
   -- macOS環境設定
  opt.guifontwide = 'Menlo:h14'  -- 全角文字用フォント
  opt.guifont = 'Menlo:h14'      -- 半角文字用フォント

  -- Command+[ で前の位置、Command+] で次の位置に移動
  vim.keymap.set('n', '<D-[>', 'g;', { noremap = true })
  vim.keymap.set('n', '<D-]>', 'g,', { noremap = true })
elseif vim.fn.has('win64') == 1 then
  -- Windows環境設定
  opt.directory = 'C:\\WINDOWS\\Temp'        -- スワップファイル保存先
  opt.ambiwidth = 'double'                   -- 曖昧幅文字を全角扱い
  opt.guifont = 'Consolas:h12'               -- 半角文字用フォント
  opt.guifontwide = 'UD_デジタル_教科書体_N:h1' -- 全角文字用フォント
end

-- GUI要素の非表示設定
-- guioptionsは文字列として扱われるため、vim.cmdを使用
vim.cmd('set guioptions-=T')  -- ツールバーを非表示
vim.cmd('set guioptions-=m')  -- メニューバーを非表示
vim.cmd('set guioptions-=r')  -- 右スクロールバーを非表示
vim.cmd('set guioptions-=R')  -- 右スクロールバーを非表示（分割時）
vim.cmd('set guioptions-=l')  -- 左スクロールバーを非表示
vim.cmd('set guioptions-=L')  -- 左スクロールバーを非表示（分割時）
vim.cmd('set guioptions-=b')  -- 下部スクロールバーを非表示

-- Unix系OSでの自動クリップボード機能を抑制
-- ビジュアルモードで選択した文字列の自動クリップボード登録を無効化
if vim.fn.has('unix') == 1 then
  vim.cmd('set guioptions-=a')
end

-- Windows環境でのIME状態別カーソル色設定
if vim.fn.has('xim') == 1 or vim.fn.has('multi_byte_ime') == 1 then
  vim.api.nvim_set_hl(0, 'Cursor', {
    fg = '#000d18',
    bg = '#8faf9f',
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'CursorIM', {
    fg = 'NONE',
    bg = '#ecbcbc',
  })
end

-- IME自動制御設定
-- 挿入モード終了時にIMEを自動的にオフにする
-- 注意: imdisableはNeovimではサポートされていないため、iminsertを使用
local ime_group = vim.api.nvim_create_augroup('InsModeAu', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdwinEnter' }, {
  group = ime_group,
  callback = function()
    opt.iminsert = 0
  end,
})
vim.api.nvim_create_autocmd({ 'InsertLeave', 'CmdwinLeave' }, {
  group = ime_group,
  callback = function()
    opt.iminsert = 0
  end,
})

-- タブ移動キーバインド
vim.keymap.set('n', '<C-S-Tab>', ':tabprev<CR>', { noremap = true })
vim.keymap.set('n', '<C-Tab>', ':tabnext<CR>', { noremap = true })
