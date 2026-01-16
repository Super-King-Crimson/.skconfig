-- Ctrl-S to save
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>")
vim.keymap.set({ "n" }, "<Leader><C-s>", "<cmd>wa<CR>", { desc = "[S]ave all" })

-- Quitting suite (Ctrl-F for farewell)
local function farewell()
  -- whether or not we were successful in saving every buffer
  -- (example: some scratch buffer)
  pcall(function()
    vim.cmd("silent! wa!")
  end)

  -- we still want to quit
  vim.cmd("qa!")
end

vim.keymap.set({ "", "!", "t" }, "<C-f>d", "<cmd>bdelete<CR>", { desc = "[D]elete the current buffer" })
vim.keymap.set({ "", "!", "t" }, "<C-f>f", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set({ "", "!", "t" }, "<C-f>s", "<cmd>wq<CR>", { desc = "[S]ave and quit" })
vim.keymap.set({ "", "!", "t" }, "<C-f>a", "<cmd>qa<CR>", { desc = "Quit [A]ll" })

vim.keymap.set({ "", "!", "t" }, "<C-f>!d", "<cmd>bdelete<CR>", { desc = "Force delete the current buffer" })
vim.keymap.set({ "", "!", "t" }, "<C-f>!f", "<cmd>q!<CR>", { desc = "Force Quit" })

vim.keymap.set({ "", "!", "t" }, "<C-f>!yf", "<cmd>qa!<CR>", { desc = "Force Quit All (are you sure?)" })
vim.keymap.set(
  { "", "!", "t" },
  "<C-f>!yb",
  "<cmd>%bdelete!<CR>",
  { desc = "Force delete ALL buffers (are you sure?)" }
)

vim.keymap.set({ "", "!", "t" }, "<C-f>F", farewell, { desc = "Catch you later! 👋" })
