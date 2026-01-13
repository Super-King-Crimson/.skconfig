-- Opens line below/above but stays in normal mode
vim.keymap.set("n", "<A-o>", "o<Esc>cc<Esc>")
vim.keymap.set("n", "<A-O>", "O<Esc>cc<Esc>")

-- Clears search highlighting and cancels all macros
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>q<Esc>")
