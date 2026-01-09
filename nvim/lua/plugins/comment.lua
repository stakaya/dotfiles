-- コメント切り替え設定（tcommentの代替）
return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Ctrl+/ でコメント切り替え
      keymap('n', '<C-_>', function()
        require('Comment.api').toggle.linewise.current()
      end, opts)
      keymap('v', '<C-_>', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
      end, opts)
    end,
  },
}
