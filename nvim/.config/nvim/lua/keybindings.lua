-- Run keybindings-debug-mode.lua
require("keybindings-debug-mode")

-- Exit terminal mode with escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- Remove search highlighting with escape
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
