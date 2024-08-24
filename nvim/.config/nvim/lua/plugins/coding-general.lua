return {
  -- Copilot
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.keymap.set(
        "i",
        "<C-J>",
        'copilot#Accept("")',
        { expr = true, replace_keycodes = false, desc = "Accept Copilot suggestion" }
      )
      vim.g.copilot_no_tab_map = true

      vim.keymap.set("i", "<C-K>", "<Plug>(copilot-accept-line)")
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
    end,
  },

  -- Terminal shenanigans
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      vim.o.hidden = true
      require("toggleterm").setup({
        open_mapping = [[<Space>tt]],
        insert_mappings = false,
      })
    end,
  },

  -- Better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = false,
    config = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      -- Folding capabilities for LSP servers should be set already in mason-lspconfig b/c it has a higher priority
      require("ufo").setup()
    end,
  },

  -- Indentation lines to guide you
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = true },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    init = function()
      -- Linters that don't support linting from stdin need to be run on write
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- Get the filetype of the current buffer
          local ft_no_stdin = { "cmake", "c", "cpp", "make", "javascript", "java", "markdown", "vim", "zsh" }
          local ft = vim.bo.filetype
          -- If the filetype is not in the table, return
          if not ft_no_stdin[ft] then
            return
          end
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require("lint").try_lint()

          -- You can call `try_lint` with a linter name or a list of names to always
          -- run specific linters, independent of the `linters_by_ft` configuration
          require("lint").try_lint("cspell")
        end,
      })
      -- The rest of the linters can be run when the buffer is changed
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = function()
          local ft_stdin = { "latex", "html", "json", "python", "lua", "ps1", "sh" }
          local ft = vim.bo.filetype
          if not ft_stdin[ft] then
            return
          end
          require("lint").try_lint()
          require("lint").try_lint("cspell")
        end,
      })
    end,
    config = function()
      require("lint").linters_by_ft = {
        c = { "cpplint" },
        cmake = { "cmakelint" },
        cpp = { "cpplint" },
        html = { "htmlhint" },
        java = { "checkstyle" },
        javascript = { "biomejs" },
        json = { "jsonlint" },
        latex = { "chktex" }, -- Not in mason
        lua = { "luacheck" },
        make = { "checkmake" },
        markdown = { "markdownlint" },
        ps1 = { "shellcheck" },
        python = { "flake8" },
        sh = { "shellcheck" },
        vim = { "vint" },
        zsh = { "zsh" }, -- Not in mason
      }
    end,
  },

  -- Formatter
  {
    "mhartington/formatter.nvim",
    init = function()
      vim.api.nvim_create_augroup("__formatter__", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = "__formatter__",
        command = ":FormatWrite",
      })
    end,
    cmd = { "FormatWrite" },
    config = function()
      require("formatter").setup({
        filetype = {
          c = { require("formatter.filetypes.c").clangformat },
          html = { require("formatter.filetypes.html").prettierd },
          java = { require("formatter.filetypes.java").clangformat },
          javascript = {
            require("formatter.filetypes.javascript").clangformat,
            require("formatter.filetypes.javascript").prettierd,
          },
          json = { require("formatter.filetypes.json").prettierd },
          latex = { require("formatter.filetypes.latex").latexindent },
          lua = {
            function()
              local util = require("formatter.util")
              local args
              if vim.fn.filereadable(".stylua.toml") == 1 or vim.fn.filereadable("stylua.toml") == 1 then
                args = {
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                }
              else
                args = {
                  "--config-path",
                  vim.fn.stdpath("config") .. "/lua/plugins/config/formatter/stylua.toml",
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                }
              end
              return {
                exe = "stylua",
                args = args,
                stdin = true,
              }
            end,
          },
          markdown = { require("formatter.filetypes.markdown").prettierd },
          python = {
            require("formatter.filetypes.python").autoflake,
            require("formatter.filetypes.python").isort,
            require("formatter.filetypes.python").ruff,
            require("formatter.filetypes.python").autopep8,
          },
          sh = { require("formatter.filetypes.sh").shfmt },
          zsh = { require("formatter.filetypes.zsh").beautysh },
          ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        },
      })
    end,
  },

  -- Add git signs to the left of the line number
  -- "airblade/vim-gitgutter",
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = true,
  },

  -- Facilitates using treesitter's interface (TS is for syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = require("plugins.config.nvim-treesitter.parsers"),
        sync_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            if lang == "latex" then
              return
            end
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = { enable = true },
      })
    end,
  },

  -- Testing code
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    ft = { "python" },
    opts = function()
      return {
        adapters = {
          require("neotest-python"),
        },
      }
    end,
  },

  -- Easily comment code sections
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- tag = '0.1.6', or branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      -- You dont need to set any of these options. These are the default ones. Only the loading is important
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      telescope.load_extension("fzf")

      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        callback = function()
          require("which-key").register({
            g = {
              name = "Goto",
              d = { vim.lsp.buf.definition, "Go to definition" },
              r = {
                require("telescope.builtin").lsp_references,
                "Open a telescope window with references",
              },
            },
          }, { buffer = 0 })
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.config.nvim-cmp.config")
    end,
  },

  -- Auto close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        enable_check_bracket_line = false,
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
