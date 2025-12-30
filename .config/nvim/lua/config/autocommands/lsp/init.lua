local hover_highlight = require("config.autocommands.lsp.hover_highlight")
local lsp_keymaps = require("config.autocommands.lsp.lsp_keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    hover_highlight(event)
    lsp_keymaps(event)
  end,
})
