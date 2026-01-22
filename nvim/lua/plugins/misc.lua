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

  -- open-browser.vim
  {
    'tyru/open-browser.vim',
    config = function()
      local function open_url_or_search()
        local q = vim.fn.getreg('/')
        q = vim.fn.trim(q)

        if q:match('^https?://') then
          vim.fn['openbrowser#open'](q)
        else
          vim.cmd('OpenBrowserSmartSearch ' .. q)
        end
      end

      vim.keymap.set('n', '<leader>b', function()
        local word = vim.fn.expand('<cword>')
        vim.fn.setreg('/', word)
        vim.opt.hlsearch = true
        open_url_or_search()
      end, { noremap = true, silent = true })

      vim.keymap.set('v', '<leader>b', function()
        vim.cmd('normal! "zy')
        vim.fn.setreg('/', vim.fn.getreg('z'))
        vim.opt.hlsearch = true
        open_url_or_search()
      end, { noremap = true, silent = true })
    end,
  },

  -- qfreplace
  {
    'thinca/vim-qfreplace',
    cmd = 'Qfreplace',
    config = function()
      vim.keymap.set('n', '<leader>R', ':Qfreplace<CR>', { noremap = true, silent = true })
    end,
  },

  -- previm（Markdownプレビュー）
  {
    'kannokanno/previm',
    ft = { 'markdown', 'md' },
    cmd = 'PrevimOpen',
  },

  -- vim-markdown
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown', 'md' },
  },

  -- TypeScript
  {
    'leafgarland/typescript-vim',
    ft = { 'typescript', 'ts' },
  },
  {
    'peitalin/vim-jsx-typescript',
    ft = { 'typescript', 'ts', 'tsx' },
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
