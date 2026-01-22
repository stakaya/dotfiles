-- コメント切り替え設定（tcommentの代替）
return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
}
