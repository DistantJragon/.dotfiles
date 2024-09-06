-- Set the host programs for the programming languages nvim will use
require("host-programs")

-- Set the leader key (needs to be set before any mappings, even plugin mappings)
vim.g.mapleader = " "

vim.g.djn_debug_mode = false

require("lazy-init")
require("keybindings")

-- Set options
local set = vim.opt

local tab_size = 2
local text_window_width = 120

-- show matching brackets and parentheses
set.showmatch = true
-- case insensitive searching with / key
set.ignorecase = true
-- number of columns occupied by a tab
set.tabstop = tab_size
-- multiple spaces act like tab-stops so the Backspace key deletes multiple spaces
set.softtabstop = tab_size
-- converts tabs to white space
set.expandtab = true
-- width for auto-indents
set.shiftwidth = tab_size
-- add line numbers
set.number = true
-- set a column border for good coding style
set.colorcolumn = tostring(text_window_width)
-- use system clipboard when yanking and pasting
set.clipboard = "unnamedplus"
-- highlight current cursor line
set.cursorline = true
-- wrap long lines once they pass the highlighted column
set.textwidth = text_window_width
-- how many lines must surround the cursor before the window scrolls
set.scrolloff = 5
-- shows line # and character # in the status bar (n/a for lua-statusline)
set.ruler = true
-- new horizontal split windows appear below
set.splitbelow = true
-- new vertical split windows appear to the right
set.splitright = true
-- specify special characters
set.listchars = { trail = "•", nbsp = "•" }
-- show special characters
set.list = true
-- save session options (removed saving folds b/c it was causing errors and ufo does it anyway)
set.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal"
