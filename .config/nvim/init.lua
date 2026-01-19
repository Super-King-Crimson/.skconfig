vim.g.mapleader = " "

vim.g.maplocalleader = "s"
vim.keymap.set("", "s", "<Nop>", { silent = true, noremap = true })

vim.g.have_nerd_font = true

-- Set up everything
-- gets lazy so static plugin setup also goes here
require("skc.keymaps")
require("skc.options")
require("skc.commands")
require("lazynvim")

vim.cmd.colorscheme("moonfly")
