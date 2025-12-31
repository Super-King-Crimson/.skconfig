-- Options --
-- we'll figure it out
-- vim.o.foldmethod = "expr"

vim.o.wrap = false

-- For kickstart
vim.o.updatetime = 250

-- they're not recorded as the same keypress
-- or ig nevermind then
vim.o.timeout = true
vim.o.timeoutlen = 1000

-- case-insensitive search
vim.o.smartcase = false
vim.o.ignorecase = true

-- makes vim stop the search at the top/bottom of a file
vim.o.wrapscan = false

-- makes vim look for stuff while you're still typing it in
vim.o.incsearch = true

vim.o.number = true

vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.softtabstop = 2

-- joining the spaces gang
vim.o.expandtab = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- MAXIMUM POWER!!!!!
vim.o.scrolloff = 999
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Save and restore things to DAta file (persist after shutdown and on closing vim)
-- !  = global variables
-- %n = store the n most recently opened buffers
-- 'n = store marks for the n most recently opened files
-- /n = store n recently used search pattern items
-- :n = store n most recently executed commands
-- @n = store n most recent items in input line
-- h  = highlight search does not work in a .shada file
-- sn = max size an item can be, in KB
vim.o.shada = "!,%10,'10,/0,:100,@100,h,s100"

require("config.options.diagnostics")
