-- See :h map-modes for what everything means
vim.keymap.set({ "!", "t" }, "<A-h>", "<Left>")
vim.keymap.set({ "!", "t" }, "<A-j>", "<Down>")
vim.keymap.set({ "!", "t" }, "<A-k>", "<Up>")
vim.keymap.set({ "!", "t" }, "<A-l>", "<Right>")
vim.keymap.set({ "!", "t" }, "<A-n>", "<C-Right>")
vim.keymap.set({ "!", "t" }, "<A-p>", "<C-Left>")

vim.keymap.set("i", "<A-c>", "<C-g>u<Esc>cc")
vim.keymap.set("i", "<A-n>", "<Esc>ea")
vim.keymap.set("i", "<A-p>", "<Esc>gea")

-- Backspacing and undos
vim.keymap.set({ "!", "t" }, "<C-h>", "<C-w>")
vim.keymap.set("i", "<C-h>", "<C-g>u<C-w>")
