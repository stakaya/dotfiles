-- LSP設定
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()

      local lspconfig = require('lspconfig')
      local keymap = vim.keymap.set

      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
        keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
        keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
        keymap('n', 'gr', vim.lsp.buf.references, bufopts)
        keymap('n', 'K', vim.lsp.buf.hover, bufopts)
        keymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        keymap('n', '<leader>==', function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
        keymap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

        vim.opt_local.signcolumn = 'yes'
      end

      -- Mason-lspconfigで自動セットアップ (v2.x API)
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'jsonls',
          'lemminx',
          'lua_ls',
          'marksman',
          'pyright',
          'taplo',
          'vimls',
          'yamlls',
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
            })
          end,
          ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
              on_attach = on_attach,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                  },
                },
              },
            })
          end,
        },
      })

      -- 診断表示設定
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
    end,
  },
}
