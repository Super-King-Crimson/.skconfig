return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    vim.keymap.set(
      "n",
      "<Leader>op",
      "<cmd>LivePreview close<CR><cmd>LivePreview start<CR>",
      { desc = "[O]pen Live [P]review" }
    )
  end,
}
