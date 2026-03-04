-- Trust this is useful
vim.keymap.set("n", "<Leader>.", "<cmd>cd %:h<CR>", { desc = "Set workspace directory to that of current buffer" })
vim.keymap.set("n", "<Leader>|", "<cmd>tcd %:h<CR>", { desc = "Set tab directory to that of current buffer" })

vim.keymap.set("n", "<Leader>F", "<cmd>wincmd o<CR>", { desc = "[F]ocus!" })

vim.keymap.set("", "<Leader>x", '"_x', { desc = "Delete into black hole register" })
vim.keymap.set("", "<Leader>d", '"_d', { desc = "Delete into black hole register" })

require("skc.keymaps.diagnostics")
require("skc.keymaps.fold")
require("skc.keymaps.insert_ext")
require("skc.keymaps.macro")
require("skc.keymaps.movement")
require("skc.keymaps.normal_ext")
require("skc.keymaps.open")
require("skc.keymaps.save_quit_delete")
require("skc.keymaps.tabs")
require("skc.keymaps.terminal_ext")
require("skc.keymaps.visual_ext")
require("skc.keymaps.which")
