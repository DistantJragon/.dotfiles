return {
  -- Working with LaTeX
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.matchup_override_vimtex = 1
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<Leader>e", function()
        require("nvim-tree.api").tree.open()
      end, { desc = "Open/Focus NvimTree" })
    end,
  },

  -- Status line at the bottom of the screen
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      open_on_setup = true,
      open_on_setup_file = true,
      sections = {
        lualine_a = {
          "mode",
          function()
            return vim.g.djn_debug_mode and "DEBUG" or ""
          end,
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
          function()
            local linters = require("lint").get_running()
            if #linters == 0 then
              return "󰦕"
            end
            return "󱉶 " .. table.concat(linters, ", ")
          end,
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Color theme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("duskfox")
    end,
  },

  -- Generates tag files. (vimTeX requested)
  -- 'ludovicchabant/vim-gutentags',

  -- Manipulate surrounding enclosions like (), [], <p> (vimTeX requested)
  "tpope/vim-surround",

  -- Extends Vim's surrounding enclosions for language specific surroundings (vimTeX requested)
  "andymass/vim-matchup",

  -- Shows a popup with possible keybindings after starting a keybind sequence
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
