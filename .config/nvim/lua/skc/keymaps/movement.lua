-- [J]ump around text faster
-- vim.keymap.set("", "<leader>jj", "/^\\s*$\\|\\%$\\|\\%^<CR><cmd>nohlsearch<CR>", { desc = "[J]ump up to next line" })
-- vim.keymap.set("", "<leader>jk", "?^\\s*$\\|\\%$\\|\\%^<CR><cmd>nohlsearch<CR>", { desc = "[J]ump down to next line" })
vim.keymap.set("", "<leader>J", "{", { desc = "[J]ump up to next line" })
vim.keymap.set("", "<leader>j", "}", { desc = "[j]ump down to next line" })

-- Better jk (spans wrapped lines)
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

-- in case for some reason you WANT to skip a long ass line
vim.keymap.set("", "gj", "j")
vim.keymap.set("", "gk", "k")

-- gh and gl go to beginning and end of current line (tf even is $ and ^)
vim.keymap.set("", "gh", "^", { desc = "[G]o to beginning of line" })
vim.keymap.set("", "gl", "$", { desc = "[G]o to end of line" })

vim.keymap.set("", "<C-j>", "3j")
vim.keymap.set("", "<C-k>", "3k")
