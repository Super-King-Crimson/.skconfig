-- Prereqs --
-- Set this to make lazy do what its supposed to do
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = false

-- End Prereqs --

-- Options --
-- 12/27/25
-- For kickstart
vim.o.updatetime = 250

-- 12/26/25
-- Since Alt is esc we're gonna try to make this seamless
-- If the keys aren't pressed at the same time,
-- they're not recorded as the same keypress
vim.o.timeout = true
vim.o.timeoutlen = 0

-- 12/23/25
-- case-insensitive search
vim.o.smartcase = false
vim.o.ignorecase = true

--12/16/25

-- makes vim stop the search at the top/bottom of a file
vim.o.wrapscan = false

-- makes vim look for stuff while you're still typing it in
vim.o.incsearch = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- 12/27
-- joining the spaces gang
vim.o.expandtab = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

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

-- End Options --

-- Basic Keymaps --

--  See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- 12/26/25
-- For some reason for my terminal Alt+<key> sends Esc+<key>,
-- so we're manually rebinding the Alt rebinds we want to use
-- ! = insert and command line
vim.keymap.set("!", "<Esc>h", "<A-h>", { remap = true })
vim.keymap.set("!", "<Esc>j", "<A-j>", { remap = true })
vim.keymap.set("!", "<Esc>k", "<A-k>", { remap = true })
vim.keymap.set("!", "<Esc>l", "<A-l>", { remap = true })
vim.keymap.set("!", "<Esc>u", "<A-u>", { remap = true })
vim.keymap.set("!", "<Esc>o", "<A-o>", { remap = true })

-- See :h map-modes for what everything means
-- Extending insert mode commands with Alt
vim.keymap.set("!", "<A-h>", "<Esc>gea")
vim.keymap.set("!", "<A-j>", "<Down>")
vim.keymap.set("!", "<A-k>", "<Up>")
vim.keymap.set("!", "<A-l>", "<Esc>ea")
vim.keymap.set("!", "<A-u>", "<Esc>ua")
vim.keymap.set("i", "<A-o>", "<Esc>A<CR><Esc>^Da")
vim.keymap.set("i", "<A-O>", "<Esc>I<CR><Esc>ka")

-- Extending normal mode commands with Alt
vim.keymap.set("n", "<A-o>", "A<CR><Esc>^D")
vim.keymap.set("n", "<A-O>", "I<CR><Esc>k")

-- In terminals, Ctrl+h = Ctrl+<BS>
vim.keymap.set("n", "<C-A-h>", "^D")
vim.keymap.set("!", "<C-A-h>", "<End> <C-u>")
vim.keymap.set("n", "<C-h>", "a<C-w><Esc>")
vim.keymap.set("!", "<C-h>", "<C-w>")

-- End Basic Keymaps --
-- Custom Commands --

-- :cd %:h switches working directory to that of the current buffer
-- :Here now does the same thing
vim.api.nvim_create_user_command("Here", "cd %:h", {})

-- End Custom Commands


--  Autocommands --
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- End Autocommands --

-- Set up lazy.nvim (plugins)
require("config.lazy")
