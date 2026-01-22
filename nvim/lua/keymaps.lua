-- Neovimキーマッピング設定
-- vimrc.keymapからの移行版

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- セミコロンとコロンのキーバインド入れ替え
keymap('n', ';', ':', { noremap = true })
keymap('n', ':', ';', opts)
keymap('v', ';', ':', { noremap = true })
keymap('v', ':', ';', opts)

-- ビジュアルモード時のバックスペースで削除
keymap('v', '<BS>', 'd', opts)

-- Windows風クリップボード操作
keymap('v', '<C-X>', '"+x', opts)
keymap('v', '<C-C>', '"+y', opts)

-- Ctrl+V でペースト
keymap({ 'n', 'v' }, '<C-V>', '"+gP', opts)
keymap('c', '<C-V>', '<C-R>+', { noremap = true })
keymap('i', '<C-V>', '<C-R>+', opts)

-- Ctrl+S でファイル保存
keymap('n', '<C-S>', ':update<CR>', opts)
keymap('v', '<C-S>', '<C-C>:update<CR>', opts)
keymap('i', '<C-S>', '<C-O>:update<CR>', opts)

-- Redo操作の改善
keymap('n', 'U', '<C-R>', opts)

-- Ctrl+Z でアンドゥ
keymap('n', '<C-Z>', 'u', opts)
keymap('i', '<C-Z>', '<C-O>u', opts)

-- Ctrl+A で全選択
keymap('n', '<C-A>', 'gggH<C-O>G', opts)
keymap('i', '<C-A>', '<C-O>gg<C-O>gH<C-O>G', opts)

-- 選択時のペースト改善
keymap('n', 'P', '"0P', opts)

-- 履歴移動コマンド
keymap('n', 'H', '<C-O>', opts)
keymap('n', 'L', '<C-I>', opts)

-- ESCキーの代替
keymap('i', 'jj', '<ESC>', opts)

-- 矩形選択の簡易化
keymap('n', 'vv', '<C-V>', opts)

-- ファイル全体の整形
keymap('n', '==', 'ggvG$=<C-O><C-O>', opts)

-- 画面分割操作
keymap('n', '_', ':split<CR><C-W>w', opts)
keymap('n', '<BAR>', ':vsplit<CR><C-W>w', opts)

-- ウィンドウ切り替え
keymap('n', '<TAB>', '<C-W>w', opts)
keymap('o', '<TAB>', '<C-C><C-W>w', opts)

-- バッファ移動
keymap('n', 'gb', ':bnext<CR>', opts)
keymap('n', 'gB', ':bprev<CR>', opts)

-- タブ操作
keymap('n', 'gn', ':tabnew<CR>', opts)

-- ウィンドウリサイズ
keymap('n', '<S-LEFT>', '<C-W><', opts)
keymap('n', '<S-RIGHT>', '<C-W>>', opts)
keymap('n', '<S-DOWN>', '<C-W>+', opts)
keymap('n', '<S-UP>', '<C-W>-', opts)

-- ハイライトサーチ解除
keymap('n', '<C-l>', ':<C-u>nohlsearch<CR><C-l>', opts)

-- ターミナル
keymap('n', '<leader>t', ':terminal<CR>', opts)
keymap('t', '<C-l>', '<C-\\><C-N>', opts)
keymap('t', '<C-n>', '<DOWN>', opts)
keymap('t', '<C-p>', '<UP>', opts)

-- 文字置換
keymap('n', '<leader>r', '"zyiw:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>', { noremap = true })
keymap('v', '<leader>r', '"zy:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>', { noremap = true })

-- 範囲選択文字置換
keymap('v', '<leader>R', ':s///g<Left><Left><Left>', { noremap = true })

-- 計算
keymap('n', '<leader>c', ':call setline(".",eval(getline(".")))<CR>', opts)
keymap('v', '<leader>c', ":!awk '{sum += $1} END {print sum}'<CR>", opts)

-- カウント
keymap('v', '<leader>n', ':s/^/\\=printf("%d", line(".") - line("\'<") + 1)/<CR>', opts)

-- 行の折返し変更
keymap('n', '<leader>wb', ':set wrap<CR>', opts)
keymap('n', '<leader>ww', ':set nowrap<CR>', opts)

-- 文字コードをUTF-8にする
keymap('n', '<leader>utf', ':set ff=unix<CR>:set fileencoding=utf-8<CR>:set fenc=utf-8 bomb<CR>', opts)

-- キーワードが含まれる行を削除
keymap('n', '<leader>d', '"zyiw:let @/ = @z<CR>:set hlsearch<CR>:g/<C-r>//d<Left><Left>', { noremap = true })
keymap('v', '<leader>d', '"zy:let @/ = @z<CR>:set hlsearch<CR>:g/<C-r>//d<Left><Left>', { noremap = true })

-- マクロの記録・実行
keymap('n', '<leader>M', 'qz', opts)
keymap('n', '<leader>m', '@z', opts)

-- コマンド履歴
keymap('n', '<leader>kk', ':<C-F>', opts)

-- completeopt設定
keymap('i', '<TAB>', function()
  return vim.fn.pumvisible() == 1 and '<Down>' or '<TAB>'
end, { expr = true, noremap = true })
keymap('i', '<S-TAB>', function()
  return vim.fn.pumvisible() == 1 and '<Up>' or '<S-TAB>'
end, { expr = true, noremap = true })

-- jq JSON整形
if vim.fn.executable('jq') == 1 then
  keymap('n', '<leader>json', ':%!jq \'.\' <CR>', opts)
end

-- Git対応検索関数
local function grep_git_files(keyword)
  local file_extension = '*.' .. vim.fn.expand('%:e')
  if file_extension == '*.' then
    file_extension = vim.fn.expand('%')
  end

  local git_dir = vim.fn.expand('%:p:h')
  local is_git = vim.fn.system('git -C ' .. vim.fn.shellescape(git_dir) .. ' rev-parse --git-dir 2>/dev/null')

  if vim.v.shell_error == 0 then
    vim.cmd('vimgrep /' .. keyword .. '/ `git ls-files ' .. vim.fn.shellescape(vim.fn.expand('%:p:h')) .. '`')
  else
    vim.cmd('vimgrep /' .. keyword .. '/ **/' .. file_extension)
  end
end

-- キーワードをgrep
keymap('n', '<leader>*', function()
  local word = vim.fn.expand('<cword>')
  vim.fn.setreg('/', '\\<' .. word .. '\\>')
  vim.opt.hlsearch = true
  grep_git_files(word)
end, opts)
keymap('v', '<leader>*', function()
  vim.cmd('normal! "zy')
  local word = vim.fn.getreg('z')
  vim.fn.setreg('/', word)
  vim.opt.hlsearch = true
  grep_git_files(word)
end, opts)
