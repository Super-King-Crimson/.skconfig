-- open in terminal
vim.keymap.set("n", "<Leader>ot", function()
  vim.cmd([[
    $tabnew
    terminal
    normal i
]])
end, { desc = "[O]pen [T]erminal" })

-- open in firefox
vim.keymap.set("n", "<leader>ob", [[<cmd>exe '!firefox ' .. expand("%:p")<CR>]], { desc = "[O]pen in [B]rowser" })

-- requires tmux and vscodium
vim.keymap.set(
  "n",
  "<leader>oc",
  [[<cmd>exe "!tmux new-session -d -s NVIM_VSCODE_ATTACH 'code " .. expand("%:p:h") .."'"<CR>]],
  { desc = "Dude what" }
)
