-- カラースキーム設定
return {
  {
    'blueshirts/darcula',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme darcula')
    end,
  },
}
