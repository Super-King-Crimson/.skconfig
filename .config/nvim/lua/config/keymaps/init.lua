-- 12/30/25
-- MINI.NVIM MY GOAT
vim.keymap.set({ "", "!" }, "<C-E>", "<cmd>lua MiniFiles.open()<CR>")

-- 12/28/25
-- pneumonic: shout (so loud it affects all tabs)
vim.keymap.set("n", "so", ":tabo<CR>")
vim.keymap.set("n", "sG", ":0,.-1tabdo tabc<CR>")
vim.keymap.set("n", "sg", ":.+1,$tabdo tabc<CR>")
vim.keymap.set("n", "sb", ":tabc<CR>")
vim.keymap.set("n", "sm", ":tab sp<CR>")

vim.keymap.set("n", "gm", "<cmd>e $MYVIMRC<CR>", { desc = "[G]o to $[M]YVIMRC" })
vim.keymap.set("n", "gh", "<cmd>tcd %:h<CR>", { desc = "[G]o [H]ere (to directory of current buffer)" })
vim.keymap.set("n", "g.", "<cmd>e .<CR>", { desc = "[G]o and explore ." })
vim.keymap.set("n", "g>", "<cmd>tabe .<CR>", { desc = "[G]o and explore . in new tab" })

-- no matter the mode, ctrl q to go forward in tabs
vim.keymap.set({ "", "!" }, "<C-q>", "<Esc><cmd>tabn<CR>")

-- See :h map-modes for what everything means
-- Extending insert mode commands with Alt
vim.keymap.set("!", "<A-h>", "<Left>")
vim.keymap.set("!", "<A-j>", "<Down>")
vim.keymap.set("!", "<A-k>", "<Up>")
vim.keymap.set("!", "<A-l>", "<Right>")
vim.keymap.set("!", "<C-A-h>", "<Esc>^C")

-- Extending normal mode commands with Alt
vim.keymap.set("n", "<A-o>", "o <C-w><Esc>")
vim.keymap.set("n", "<A-O>", "O <C-w><Esc>")

-- In terminals, Ctrl+h = Ctrl+<BS>
vim.keymap.set("!", "<C-A-h>", "<Esc>^C")
vim.keymap.set("!", "<C-h>", "<C-w>")

--Kickstart stuff
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
