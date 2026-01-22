-- ファイルエクスプローラー設定（vimfilerの代替）
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
              modified = false,
              diagnostics = false,
              bookmarks = false,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
      })

      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },
}
