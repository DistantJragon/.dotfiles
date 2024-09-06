local M = {
  -- Working with LaTeX
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.matchup_override_vimtex = 1
    end,
  },

  -- Generates tag files. (vimTeX requested)
  -- 'ludovicchabant/vim-gutentags',

  -- Manipulate surrounding enclosions like (), [], <p> (vimTeX requested)
  "tpope/vim-surround",
}

if
  vim.fn.executable("cc") == 1
  or vim.fn.executable("gcc") == 1
  or vim.fn.executable("clang") == 1
  or vim.fn.executable("cl") == 1
  or vim.fn.executable("zig") == 1
then
  -- Extends Vim's surrounding enclosions for language specific surroundings (vimTeX requested)
  table.insert(M, "andymass/vim-matchup")
end

return M
