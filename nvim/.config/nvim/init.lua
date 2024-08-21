-- Set the Python 3 host program
vim.g.python3_host_prog = "/usr/bin/python3"

-- Set the leader key
vim.g.mapleader = " "

vim.g.djn_debug_mode = false

require("lazy-init")
require("keybindings")

-- Set options
local set = vim.opt

set.showmatch = true -- show matching [s, (s, {s
set.ignorecase = true -- case insensitive searching with /
set.tabstop = 2 -- number of columns occupied by a tab
set.softtabstop = 2 -- multiple spaces act like tab-stops so <BS> deletes multiple spaces
set.expandtab = true -- converts tabs to white space
set.shiftwidth = 2 -- width for auto-indents
set.number = true -- add line numbers
set.colorcolumn = "120" -- set a column border for good coding style
set.clipboard = "unnamedplus" -- using system clipboard
set.cursorline = true -- highlight current cursor line
set.textwidth = 120 -- wrap long lines once they pass the highlighted column
set.scrolloff = 5 -- how many lines must surround the cursor before the window scrolls
set.ruler = true -- shows line # and character # in the status bar (n/a for lua-statusline)
set.splitbelow = true -- new horizontal split windows appear below
set.splitright = true -- new vertical split windows appear to the right
set.listchars = { trail = "•", nbsp = "•" } -- specify special characters
set.list = true -- show special characters
set.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal" -- save session options (removed saving
-- folds b/c it was causing errors and ufo does it anyway)
