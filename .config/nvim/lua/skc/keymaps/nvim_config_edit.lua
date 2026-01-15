vim.keymap.set("n", "<Leader>nn", [[<cmd>exe 'e ' ..stdpath('config')<CR>]], { desc = "From directory of init.lua" })

vim.keymap.set(
  "n",
  "<Leader>na",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/skc/autocommands' <CR>]],
  { desc = "[N]eovim [A]utocommands" }
)

vim.keymap.set(
  "n",
  "<Leader>no",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/skc/options/init.lua' <CR>]],
  { desc = "[N]eovim [O]ptions" }
)

vim.keymap.set(
  "n",
  "<Leader>nk",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/skc/keymaps' <CR>]],
  { desc = "[N]eovim [K]eymaps" }
)

vim.keymap.set(
  "n",
  "<Leader>nl",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/lazynvim' <CR>]],
  { desc = "[N]eovim [L]azy Plugins" }
)

vim.keymap.set(
  "n",
  "<Leader>np",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/lazynvim' <CR>]],
  { desc = "[N]eovim Lazy [P]lugins" }
)
