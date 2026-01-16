-- Options --
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.wrap = false
vim.o.updatetime = 250

vim.o.timeout = true
vim.o.timeoutlen = 5000

-- case-insensitive search
vim.o.smartcase = false
vim.o.ignorecase = true

vim.o.wrapscan = false
vim.o.incsearch = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.shiftwidth = 0
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.mouse = "a"
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.inccommand = "split"
vim.o.cursorline = true

-- MAXIMUM POWER!!!!!
-- nvm minimum power
vim.o.scrolloff = 999
vim.o.confirm = true

-- Save and restore things to SHAred DAta file (persist after shutdown and on closing vim)
-- !  = global variables
-- %n = store the n most recently opened buffers
-- 'n = store marks for the n most recently opened files
-- /n = store n recently used search pattern items
-- :n = store n most recently executed commands
-- @n = store n most recent items in input line
-- h  = highlight search does not work in a .shada file
-- sn = max size an item can be, in KB
vim.o.shada = "'10,/0,:100,@100,h,s100"

require("skc.options.diagnostics")
