-- tab manipulation commands (s for shout, because t is kinda far...)
-- CTRL-TAB COME BACK
vim.keymap.set("n", "sj", "gT")
vim.keymap.set("n", "sk", "gt")

-- clear left/right
vim.keymap.set("n", "sch", "<cmd>0,.-1tabdo tabc<CR>")
vim.keymap.set("n", "scl", "<cmd>.+1,$tabdo tabc<CR>")
vim.keymap.set("n", "scc", "<cmd>tabc<CR>")
vim.keymap.set("n", "sx", "<cmd>tabc<CR>")
vim.keymap.set("n", "sp", "<cmd>tab sp<CR>")
vim.keymap.set("n", "sn", "<cmd>tabe<CR>")

-- 5 tabs
vim.keymap.set({ "", "!", "t" }, "<A-1>", "<cmd>1tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-2>", "<cmd>2tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-3>", "<cmd>3tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-4>", "<cmd>4tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-5>", "<cmd>5tabnext<CR>")

-- Swap between two tabs
vim.keymap.set({ "!", "", "t" }, "<A-s>", "<Esc><Esc>:tabnext #<CR>")

-- Shout only
vim.keymap.set("n", "so", ":tabo<CR>")
