return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    vim.keymap.set("n", "<Leader>op", ":LivePreview start<CR>", { desc = "[O]pen Live [P]review" })
  end,
}
