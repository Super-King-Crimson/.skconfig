-- Open suite
-- open in terminal
vim.keymap.set("n", "<Leader>ot", function()
  vim.cmd([[
    $tabnew
    terminal
    normal i
  ]])
end, { desc = "[O]pen [T]erminal" })

-- open in firefox
vim.keymap.set("n", "<leader>ob", [[<cmd>exe '!firefox ' .. expand("%:p")<CR>]], { desc = "[O]pen in [B]rowser" })

-- what the fuck
-- obviously requires tmux in path
vim.keymap.set(
  "n",
  "<leader>oc",
  [[<cmd>exe "!tmux new-session -d -s NVIM_VSCODE_ATTACH 'codium " .. expand("%:p:h") .."'"<CR>]],
  { desc = "Dude what" }
)

-- [J]ump around text faster
vim.keymap.set("", "<leader>jj", "}", { desc = "[J]ump up to next line" })
vim.keymap.set("", "<leader>jk", "{", { desc = "[J]ump down to next line" })
vim.keymap.set("", "<leader>jh", "20k", { desc = "[J]ump [H]igh" })
vim.keymap.set("", "<leader>jl", "20j", { desc = "[J]ump [L]ow" })

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

-- Ctrl-X: deleting/quitting suite
vim.keymap.set("n", "<C-w>q", "<Nul>", { desc = "No more quick quitting!" })

vim.keymap.set({ "", "!", "t" }, "<C-x>d", "<cmd>bdelete<CR>", { desc = "[D]elete the current buffer" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fd", "<cmd>bdelete!<CR>", { desc = "[F]orce [D]elete the current buffer" })

vim.keymap.set({ "", "!", "t" }, "<C-x>a", "<cmd>wa|qa!<CR>", { desc = "Write and quit [A]ll" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fa", "<cmd>qa!<CR>", { desc = "[F]orce quit [A]ll" })

vim.keymap.set({ "", "!", "t" }, "<C-x>w", "<cmd>w|q!<CR>", { desc = "[W]rite and quit" })
vim.keymap.set({ "", "!", "t" }, "<C-x>x", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set({ "", "!", "t" }, "<C-x>fx", "q!", { desc = "[F]orce Quit" })

vim.keymap.set("n", "<C-x>n", "/\\vx^<CR>", { desc = "Clear [N] (for search)" })

-- MINI.NVIM MY GOAT
vim.keymap.set(
  "n",
  "<Leader>os",
  "<cmd>echo input('This will delete all unsaved files. Press Enter or Esc to confirm, C-c to cancel > ')|e! dummy|%bd!|edit #|bd #|lua MiniStarter.open()<CR>",
  { desc = "[O]pen [S]tartup screen" }
)

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

vim.keymap.set({ "", "i" }, "<C-l>", function()
  vim.cmd.normal("<Esc>")
  miniFileToggle(true)
end, { desc = "Explore directory of [l]ocal buffer" })

vim.keymap.set({ "", "i" }, "<C-e>", function()
  vim.cmd.normal("<Esc>")
  miniFileToggle()
end, { desc = "[E]xplore current directory" })

-- Trust this is useful
vim.keymap.set("n", "<Leader>.", "<cmd>tcd %:h<CR>", { desc = "[.] Set buffer directory to tab directory" })

-- Jump to Neovim files
vim.keymap.set("n", "<Leader>nn", [[<cmd>exe 'e ' ..stdpath('config')<CR>]], { desc = "From directory of init.lua" })
vim.keymap.set(
  "n",
  "<Leader>na",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/config/autocommands' <CR>]],
  { desc = "[N]eovim [A]utocommands" }
)
vim.keymap.set(
  "n",
  "<Leader>no",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/config/options/init.lua' <CR>]],
  { desc = "[N]eovim [O]ptions" }
)
vim.keymap.set(
  "n",
  "<Leader>nk",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/config/keymaps.lua' <CR>]],
  { desc = "[N]eovim [K]eymaps" }
)
vim.keymap.set(
  "n",
  "<Leader>nl",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/lazynvim' <CR>]],
  { desc = "[N]eovim [L]azy Plugins" }
)
vim.keymap.set(
  "n",
  "<Leader>np",
  [[<cmd>exe 'e ' ..stdpath('config') .. '/lua/lazynvim' <CR>]],
  { desc = "[N]eovim Lazy [P]lugins" }
)

-- tab manipulation commands (s for shout, because t isn't home row)
vim.keymap.set("n", "so", ":tabo<CR>")

-- CTRL-TAB COME BACK
vim.keymap.set("n", "sj", "gT")
vim.keymap.set("n", "sk", "gt")

-- clear left/right
vim.keymap.set("n", "sch", "<cmd>0,.-1tabdo tabc<CR>", { desc = "Close all tabs to left" })
vim.keymap.set("n", "scl", "<cmd>.+1,$tabdo tabc<CR>", { desc = "Close all tabs to right" })
vim.keymap.set("n", "scc", "<cmd>tabc<CR>", { desc = "Close tab" })
vim.keymap.set("n", "sx", "<cmd>tabc<CR>", { desc = "Close tab" })
vim.keymap.set("n", "sn", "<cmd>tabe<CR>")

vim.keymap.set("n", "ss", function()
  vim.cmd("tab sp")
  miniFileToggle(true)
end)

-- Esc + Esc to exit terminal (VERY IMPORTANT!)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- 6 tabs + last tab (and going to middle tab)
vim.keymap.set({ "", "!" }, "<A-1>", "<cmd>:1tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-2>", "<cmd>:2tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-3>", "<cmd>:3tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-4>", "<cmd>:4tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-5>", "<cmd>:5tabnext<CR>")
vim.keymap.set({ "", "!" }, "<A-6>", "<cmd>:6tabnext<CR>")
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

-- hjkl to move big boy
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
