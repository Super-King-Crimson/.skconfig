-- Set this to make lazy do what its supposed to do
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Set up everything
-- gets lazy so static plugin setup also goes here
require("lazynvim")
require("config.autocommands")
require("config.options")
require("config.keymaps")

-- Activate our colorscheme
vim.cmd.colorscheme("moonfly")
