vim.keymap.set("n", "<Leader>ff", "za", { desc = "[F]old toggle" })

vim.keymap.set("n", "<Leader>ft", "<cmd>%foldclose<CR>", { desc = "[F]old [T]op level of folds" })
vim.keymap.set("n", "<Leader>fr", "zR", { desc = "[F]old [R]educe" })
vim.keymap.set("n", "<Leader>fm", "zM", { desc = "[F]old [M]ore" })

vim.keymap.set("n", "<Leader>fs", "zR<cmd>%foldclose<CR>", { desc = "Set ideal [F]old [S]tate" })

vim.keymap.set("", "<leader>j", "zj", { desc = "Jump down to next fold" })
vim.keymap.set("", "<leader>k", "zk", { desc = "Jump up to previous fold" })
vim.keymap.set("", "<leader>fj", "]z", { desc = "Jump to end of current fold" })
vim.keymap.set("", "<leader>fk", "[z", { desc = "Jump to beginning of current fold" })
