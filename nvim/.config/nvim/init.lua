-- Set the host programs for the programming languages nvim will use
require("host-programs")

-- Set the leader key (needs to be set before any mappings, even plugin mappings)
vim.g.mapleader = " "

require("lazy-init")
require("keybindings")
require("nvim-options")
