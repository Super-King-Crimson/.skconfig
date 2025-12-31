-- 12/30/25
-- Better jk (spans wrapped lines)
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

-- in case for some reason you WANT to skip a long ass line
vim.keymap.set("", "gj", "j")
vim.keymap.set("", "gk", "k")

-- gh and gl go to beginning and end of current line (tf even is $ and ^)
vim.keymap.set("", "gh", "^", { desc = "[G]o to beginning of line" })
vim.keymap.set("", "gl", "$", { desc = "[G]o to end of line" })

-- Ctrl-S to save
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>")
-- MINI.NVIM MY GOAT
local function miniFileToggle(from_current_buffer)
  if require("mini.files") == nil then
    return
  end

  local variant = from_current_buffer and function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  end or function()
    MiniFiles.open(nil, false)
  end

  if MiniFiles.get_explorer_state() then
    MiniFiles.close()
  else
    variant()
  end
end

vim.keymap.set({ "", "!" }, "<C-l>", function()
  miniFileToggle(true)
end, { desc = "Explore directory of [l]ocal buffer" })

vim.keymap.set({ "", "!" }, "<C-e>", function()
  miniFileToggle()
end, { desc = "[E]xplore current directory" })

-- 12/28/25
vim.keymap.set("n", "gm", "<cmd>e $MYVIMRC<CR>", { desc = "[G]o to $[M]YVIMRC" })
vim.keymap.set("n", "g.", "<cmd>tcd %:h<CR>", { desc = "Set buffer directory to current directory" })

-- tab manipulation commands (shout!)
vim.keymap.set("n", "so", ":tabo<CR>")
-- clear left/right
vim.keymap.set("n", "sch", "<cmd>0,.-1tabdo tabc<CR>")
vim.keymap.set("n", "scl", "<cmd>.+1,$tabdo tabc<CR>")
vim.keymap.set("n", "sx", "<cmd>tabc<CR>")
vim.keymap.set("n", "sn", "<cmd>tabe <CR>")

--shout for a terminal
vim.keymap.set("n", "st", function()
  vim.cmd([[
    $tabnew
    terminal
    <normal> a
  ]])
end)

-- 4 tabs + last tab (and going to middle tab)
vim.keymap.set({ "", "!" }, "<A-1>", "<cmd>:1tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-2>", "<cmd>:2tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-3>", "<cmd>:3tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-4>", "<cmd>:4tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-0>", "<cmd>:tablast<CR>")

-- Swap between two tabs (normal mode only)
vim.keymap.set("n", "S", "<cmd>:tabnext #<CR>")

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
vim.keymap.set("!", "<C-h>", "<C-w>")

--Kickstart stuff
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- hjkl to move big boy
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
