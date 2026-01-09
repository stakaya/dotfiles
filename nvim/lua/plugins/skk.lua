-- SKK日本語入力設定
return {
  {
    'vim-skk/skkeleton',
    dependencies = { 'vim-denops/denops.vim' },
    config = function()
      local dict_dir = vim.fn.expand('~/.vim/dict')

      vim.fn['skkeleton#config']({
        globalDictionaries = { dict_dir .. '/SKK-JISYO.L' },
        userDictionary = dict_dir .. '/SKK-JISYO.user',
        eggLikeNewline = true,
        markerHenkan = '>>>',
        markerHenkanSelect = '>>>',
      })

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      keymap('i', '<C-J>', '<Plug>(skkeleton-toggle)', {})
      keymap('c', '<C-J>', '<Plug>(skkeleton-toggle)', {})
      keymap('n', '<leader>j', 'i<Plug>(skkeleton-toggle)', {})
    end,
  },
}
