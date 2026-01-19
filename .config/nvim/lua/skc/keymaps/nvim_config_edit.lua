vim.keymap.set(
  "n",
  "<Leader>nn",
  [[<cmd>exe 'e ' ..stdpath('config') ..'/init.lua'<CR>]],
  { desc = "From directory of init.lua" }
)

vim.keymap.set(
  "n",
  "<Leader>nc",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/skc/commands/init.lua' <CR>]],
  { desc = "[N]eovim [C]ommands" }
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
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/skc/keymaps/init.lua' <CR>]],
  { desc = "[N]eovim [K]eymaps" }
)

vim.keymap.set(
  "n",
  "<Leader>nl",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/lazynvim/init.lua' <CR>]],
  { desc = "[N]eovim [L]azy Plugins" }
)

vim.keymap.set(
  "n",
  "<Leader>np",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/lazynvim/init.lua' <CR>]],
  { desc = "[N]eovim Lazy [P]lugins" }
)
