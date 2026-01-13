-- Ctrl-S to save
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>")

-- Ctrl-X: deleting/quitting suite
vim.keymap.set("n", "<C-w>q", "<Nul>", { desc = "No more quick quitting!" })

vim.keymap.set({ "", "!", "t" }, "<C-x>d", "<cmd>bdelete<CR>", { desc = "[D]elete the current buffer" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fd", "<cmd>bdelete!<CR>", { desc = "[F]orce [D]elete the current buffer" })

vim.keymap.set({ "", "!", "t" }, "<C-x>a", "<cmd>qa<CR>", { desc = "Quit [A]ll" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fa", "<cmd>qa!<CR>", { desc = "[F]orce quit [A]ll" })

vim.keymap.set(
  { "", "!", "t" },
  "<C-x>ff",
  "<cmd>wa<CR><cmd>qa!<CR>",
  { desc = "[F]orce [F]arewell (save and quit all)" }
)

vim.keymap.set({ "", "!", "t" }, "<C-x>w", "<cmd>w|q!<CR>", { desc = "[W]rite and quit" })
vim.keymap.set({ "", "!", "t" }, "<C-x>s", "<cmd>w|q!<CR>", { desc = "[S]ave and quit" })

vim.keymap.set({ "", "!", "t" }, "<C-x>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fq", "<cmd>q!<CR>", { desc = "[F]orce Quit" })
vim.keymap.set({ "", "!", "t" }, "<C-x>x", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fx", "<cmd>q!<CR>", { desc = "[F]orce Quit" })
