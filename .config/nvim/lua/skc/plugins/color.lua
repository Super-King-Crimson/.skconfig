vim.schedule(
  function()
    vim.keymap.set("n", "<Leader>oc", "<cmd>CccPick<CR>", { desc = "[O]pen [C]olor Picker" })
  end
)

return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
  end,
}
