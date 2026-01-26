-- その他のプラグイン設定
return {
  -- vim-matchup（括弧マッチング拡張）
  { 'andymass/vim-matchup' },

  -- vim-abolish（単語変換・置換）
  {
    'tpope/vim-abolish',
    config = function()
      vim.keymap.set('n', '*', '"zyiw:let @/ = @z<CR>:S/<C-r>/<CR>', { noremap = true, silent = true })
      vim.keymap.set('v', '*', '"zy:let @/ = @z<CR>:S/<C-r>/<CR>', { noremap = true, silent = true })
    end,
  },

  -- editorconfig
  { 'editorconfig/editorconfig-vim' },

  -- qfreplace
  {
    'thinca/vim-qfreplace',
    cmd = 'Qfreplace',
    config = function()
      vim.keymap.set('n', '<leader>R', ':Qfreplace<CR>', { noremap = true, silent = true })
    end,
  },

  -- vim-markdown
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown', 'md' },
  },

  -- TOML
  {
    'cespare/vim-toml',
    ft = { 'toml', 'conf' },
  },

  -- Gist
  {
    'mattn/gist-vim',
    dependencies = { 'mattn/webapi-vim' },
    cmd = 'Gist',
  },

  -- hz_ja（全角半角変換）
  {
    'shinchu/hz_ja.vim',
    config = function()
      vim.keymap.set('n', '<leader>zh', ':HzjaConvert han_eisu<CR>', { noremap = true, silent = true })
      vim.keymap.set('v', '<leader>zh', ':HzjaConvert han_eisu<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>hz', ':HzjaConvert zen_kana<CR>', { noremap = true, silent = true })
      vim.keymap.set('v', '<leader>hz', ':HzjaConvert zen_kana<CR>', { noremap = true, silent = true })
    end,
  },
}
