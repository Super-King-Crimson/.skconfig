-- -- open in terminal
-- vim.keymap.set("n", "<Leader>ot", function()
--   vim.cmd([[
--     $tabnew
--     terminal
--     normal i
-- ]])
-- end, { desc = "[O]pen [T]erminal" })

-- open in firefox
vim.keymap.set("n", "<leader>ob", [[<cmd>exe '!firefox ' .. expand("%:p")<CR>]], { desc = "[O]pen in [B]rowser" })

-- requires tmux and vscodium
vim.keymap.set(
  "n",
  "<leader>of",
  [[<cmd>lua print("hey go implement the floating window plugin thingy!!!")<CR>]],
  { desc = "[O]pen floating [W]indow" }
)

-- Diagnostic keymaps
vim.keymap.set(
  "n",
  "<Leader>od",
  vim.diagnostic.setqflist,
  { desc = "[O]pen [D]iagnostics to location list" }
)

vim.keymap.set("n", "<Leader>oa", vim.lsp.buf.code_action, { desc = "[O]pen Code [A]ctions" })
