-- SKK日本語入力設定
return {
  {
    'tyru/eskk.vim',
    config = function()
      local dictionary_dir = vim.fn.expand('~/.vim/dict')
      vim.g['eskk#marker_henkan'] = "💬"
      vim.g['eskk#marker_henkan_select'] = "✅"
      vim.g['eskk#marker_jisyo_touroku'] = "📖"
      vim.g['eskk#egg_like_newline'] = 1
      vim.g['eskk#dictionary'] = { path = dictionary_dir .. '/SKK-JISYO.user', sorted = 0, encoding = 'utf-8' }
      vim.g['eskk#large_dictionary'] = { path = dictionary_dir .. '/SKK-JISYO.L', sorted = 1, encoding = 'euc-jp' }

      vim.cmd([[
        augroup eskk
          autocmd!
          autocmd User eskk-enable-post lmap <buffer> l <Plug>(eskk:disable)
        augroup END
      ]])

      vim.keymap.set('i', '<C-J>', '<Plug>(eskk:toggle)')
      vim.keymap.set('c', '<C-J>', '<Plug>(eskk:toggle)')
      vim.keymap.set('n', '<C-J>', 'i<Plug>(eskk:toggle)')
      vim.keymap.set('n', '<leader>j', 'i<Plug>(eskk:toggle)')
    end,
  },
}
