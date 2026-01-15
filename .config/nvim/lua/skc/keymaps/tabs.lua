-- tab manipulation commands (s for shout, because t is kinda far...)
-- CTRL-TAB COME BACK
vim.keymap.set("n", "sJ", "<cmd>tabfirst<CR>")
vim.keymap.set("n", "sj", "gT")
vim.keymap.set("n", "sk", "gt")
vim.keymap.set("n", "sK", "<cmd>tablast<CR>")

vim.keymap.set("n", "sn", "<cmd>tabe<CR>")
vim.keymap.set("n", "sp", "<cmd>tab sp<CR>")

-- clear left/right
vim.keymap.set("n", "scj", "<cmd>0,.-1tabdo tabc<CR>", { desc = "Close tabs to left" })
vim.keymap.set("n", "sck", "<cmd>.+1,$tabdo tabc<CR>", { desc = "Close tabs to right" })
vim.keymap.set("n", "scc", "<cmd>tabc<CR>", { desc = "Close this tab" })
vim.keymap.set("n", "sx", "<cmd>tabc<CR>")

-- move tabs
vim.keymap.set("n", "Sh", "<cmd>tabm0<CR>")
vim.keymap.set("n", "Sj", "<cmd>tabm-<CR>")
vim.keymap.set("n", "Sk", "<cmd>tabm+<CR>")
vim.keymap.set("n", "Sl", "<cmd>tabm<CR>")

vim.keymap.set("n", "SL", "<cmd>0,.tabdo tabm<CR>", { desc = "Move tabs to left to end" })

-- 5 tabs
vim.keymap.set({ "", "!", "t" }, "<A-1>", "<cmd>1tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-2>", "<cmd>2tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-3>", "<cmd>3tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-4>", "<cmd>4tabnext<CR>")
vim.keymap.set({ "", "!", "t" }, "<A-5>", "<cmd>5tabnext<CR>")

-- Swap between two tabs
vim.keymap.set({ "!", "", "t" }, "<A-s>", "<cmd>tabnext #<CR>")

-- Shout only
vim.keymap.set("n", "so", ":tabo<CR>")
