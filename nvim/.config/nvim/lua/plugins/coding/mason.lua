return {
  -- Programming plugin manager
  -- {
  --   "mason-org/mason.nvim",
  --   lazy = false,
  --   config = function()
  --     require("mason").setup({
  --       -- log_level = vim.log.levels.DEBUG,
  --     })
  --   end,
  -- },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      -- "mason-org/mason.nvim", -- Not a dependency, but should be loaded
    },
    -- LSPs should be configured with nvim's built-in LSP client
  },

  -- Connects Neovim to DAP(s)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      require("plugins.config.nvim-dap.daps")(dap)
    end,
  },

  -- Adds TUI to nvim-dap
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    lazy = false,
    config = true,
  },

  -- Prints virtual texts to warn/inform user while coding
  "theHamsta/nvim-dap-virtual-text",
}
