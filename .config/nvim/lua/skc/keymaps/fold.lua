vim.keymap.set("n", "<Leader>ff", "za", { desc = "[F]old toggle" })

vim.keymap.set("n", "<Leader>ft", "<cmd>%foldclose<CR>", { desc = "[F]old [T]op level of folds" })
vim.keymap.set("n", "<Leader>fr", "zR", { desc = "[F]old [R]educe" })
vim.keymap.set("n", "<Leader>fm", "zM", { desc = "[F]old [M]ore" })

vim.keymap.set("n", "<Leader>fs", "zR<cmd>%foldclose<CR>", { desc = "Set ideal [F]old [S]tate" })
