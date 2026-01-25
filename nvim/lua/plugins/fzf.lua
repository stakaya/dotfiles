-- fzf設定
return {
  {
    'junegunn/fzf',
    build = './install --all',
  },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- キーマッピング設定
      keymap('n', '<leader>;', ':Commands<CR>', opts)
      keymap('n', '<leader>w', ':Buffers<CR>', opts)

      -- Git対応ファイル検索関数
      local function fzf_omni_files()
        local git_dir = vim.fn.expand('%:p:h')
        local is_git = vim.fn.system('git -C ' .. vim.fn.shellescape(git_dir) .. ' rev-parse --git-dir 2>/dev/null')

        if vim.v.shell_error == 0 then
          vim.cmd('GitFiles')
        else
          vim.cmd('Files')
        end
      end

      keymap('n', '<leader><space>', fzf_omni_files, opts)

      -- ripgrep検索設定
      if vim.fn.executable('rg') == 1 then
        keymap('n', '<leader>g', function()
          local word = vim.fn.expand('<cword>')
          vim.fn.setreg('/', word)
          vim.opt.hlsearch = true
          vim.cmd('Rg ' .. word)
        end, opts)
        keymap('v', '<leader>g', function()
          vim.cmd('normal! "zy')
          local word = vim.fn.getreg('z')
          vim.fn.setreg('/', word)
          vim.opt.hlsearch = true
          vim.cmd('Rg ' .. word)
        end, opts)
      end
    end,
  },
}
