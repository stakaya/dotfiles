-- AI補完設定（vim-aiの代替）
return {
  {
    'madox2/vim-ai',
    config = function()
      vim.g.vim_ai_token_file_path = '~/.config/openai.token'

      vim.g.vim_ai_chat = {
        options = {
          model = 'gpt-5.2',
          temperature = 0.7,
        },
      }

      vim.g.vim_ai_complete = {
        options = {
          model = 'gpt-5.2',
          temperature = 0.1,
        },
      }

      vim.g.vim_ai_edit = {
        options = {
          model = 'gpt-5.2',
        },
      }

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      keymap('x', '<leader>edit', ':AIEdit<space>', { noremap = true })
      keymap('x', '<leader>ai', ':AI<CR>', opts)
      keymap('x', '<leader>fix', ':AIEdit fix grammar and spelling<CR>', opts)
      keymap('x', '<leader><CR>', ':AIChat<CR>', opts)
      keymap('n', '<leader><CR>', ':AIChat<CR>', opts)
      keymap('n', '<leader>img', ':AIImage<space>', { noremap = true })
      keymap('x', '<leader>img', ':AIImage<CR>', opts)

      -- コードレビュー関数
      vim.cmd([[
        function! CodeReviewFn(range) range
          let l:prompt = "programming syntax is " . &filetype . ", review the code below:\n" . "レビューの言語は日本語でお願いします。\n"
          let l:config = {
          \  "options": {
          \    "initial_prompt": ">>> system\nyou are a clean code expert",
          \  },
          \}
          exe a:firstline.",".a:lastline . "call vim_ai#AIChatRun(a:range, l:config, l:prompt)"
        endfunction
        command! -range -nargs=? AICodeReview <line1>,<line2>call CodeReviewFn(<range>)
      ]])
    end,
  },
}
