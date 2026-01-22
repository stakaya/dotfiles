 return {
  -- Firenvimはブラウザ側から起動される前提なので、基本は遅延させずにOK
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,

  -- プラグインが読み込まれる前に g:firenvim_config を用意する
  init = function()
    vim.g.firenvim_config = {
      localSettings = {
        [".*"] = { takeover = "never" },

        ["/firenvim\\.html([?#].*)?$"] = {
          takeover = "always",
          selector = "textarea, [contenteditable='true'], [contenteditable]",
        },
      },
    }
  end,
}

