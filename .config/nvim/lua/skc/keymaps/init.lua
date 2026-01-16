-- hjkl to move big boy
vim.keymap.set("n", "<left>", '<cmd>echo "use h to move!!"<cr>')
vim.keymap.set("n", "<down>", '<cmd>echo "use j to move!!"<cr>')
vim.keymap.set("n", "<up>", '<cmd>echo "use k to move!!"<cr>')
vim.keymap.set("n", "<right>", '<cmd>echo "use l to move!!"<cr>')

-- Diagnostic keymaps
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Trust this is useful
vim.keymap.set("n", "<Leader>.", "<cmd>cd %:h<CR>", { desc = "Set workspace directory to that of current buffer" })

require("skc/keymaps/insert_ext")
require("skc/keymaps/macro")
require("skc/keymaps/movement")
require("skc/keymaps/normal_ext")
require("skc/keymaps/nvim_config_edit")
require("skc/keymaps/open")
require("skc/keymaps/quickfix")
require("skc/keymaps/save_quit_delete")
require("skc/keymaps/tabs")
require("skc/keymaps/terminal_ext")
require("skc/keymaps/fold")
