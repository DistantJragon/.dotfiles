return {
  -- Programming plugin manager
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 52, -- Must be loaded before mason-lspconfig, lspconfig, and mason-nvim-dap
    config = function()
      local mason_daps = { "bash-debug-adapter", "cpptools", "java-debug-adapter", "js-debug-adapter" }
      -- No python dap, as it is configured in nvim-dap-python, and I honestly don't know how to configure python
      -- debugging with the executable installed by mason
      local mason_linters = { -- From nvim-lint
        "cpplint",
        "cmakelint",
        "cspell",
        "htmlhint",
        "checkstyle",
        "biome",
        "jsonlint",
        "luacheck",
        "checkmake",
        "markdownlint",
        "shellcheck",
        "flake8",
        "vint",
      }
      local mason_formatters = { -- from formatter.nvim
        "clang-format",
        "prettierd",
        "latexindent",
        "stylua",
        "autoflake",
        "isort",
        "ruff",
        "autopep8",
        "shfmt",
        "beautysh",
      }
      -- No mason_lsps, as they are configured in mason-lspconfig
      require("mason").setup()
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        require("plugins.config.mason.install-all-cmd")({ mason_daps, mason_linters, mason_formatters })
      end, {})
      -- Comment out the following line if you don't want to install all packages on startup
      vim.cmd("MasonInstallAll")
    end,
  },

  -- Connects mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 51, -- Must be loaded before lspconfig
    opts = {
      ensure_installed = {
        "asm_lsp", -- Assembly
        "basedpyright", -- Python
        "bashls", -- Bash
        "biome", -- JavaScript
        "clangd", -- C/C++
        "cmake", -- CMake
        "css_variables",
        "cssls",
        "cssmodules_ls", -- CSS
        "docker_compose_language_service",
        "dockerls", -- Docker
        "html",
        "htmx", -- HTML/HTMX
        "java_language_server", -- Java
        "jsonls", -- JSON
        "ltex", -- LaTeX
        "lua_ls", -- Lua
        "marksman", -- Markdown
        "powershell_es", -- PowerShell
        "rust_analyzer", -- Rust
        "typos_lsp", -- Spell checking
        "vimls", -- Vim
      },
    },
    config = function(_, opts)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      require("mason-lspconfig").setup(opts)
      -- Automatic LSP server setup in mason-lspconfig is "advanced."
      -- TODO: It is recommended by mason-lspconfig to manually configure LSP servers (in nvim-lspconfig).
      -- (I don't care enough to do it myself yet)
      -- Just make sure to comment out the following block if you do (see :h lspconfig-quickstart)
      require("mason-lspconfig").setup_handlers({
        -- First entry is the default handler
        function(server_name)
          require("lspconfig")[server_name].setup({ capabilities = capabilities })
        end,
        -- Custom handlers after (e.g ["pyright"] = function() ... end,)
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                return
              end

              client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  },
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
                },
              })
            end,
            settings = {
              Lua = {},
            },
          })
        end,
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    -- LSPs should be configured from within mason-lspconfig (configs can be customized there too)
  },

  -- Connects NeoVim to DAP(s)
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- python is configured within nvim-dap-python. Languages with no extensions can be added here.
      -- Configure adapters and configurations for them
      local dap = require("dap")
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7", -- mason should have added this to the path, so it should work
      }
      if vim.fn.has("win32") == 1 then
        -- dap.adapters.cppdbg.command = 'OpenDebugAD7.exe'
        dap.adapters.cppdbg.options = { detached = false }
      end
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            if vim.fn.executable(vim.fn.getcwd() .. "/a.out") == 1 then
              return vim.fn.getcwd() .. "/a.out"
            end
            if vim.fn.executable(vim.fn.getcwd() .. "/a.exe") == 1 then
              return vim.fn.getcwd() .. "/a.exe"
            end
            local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            if vim.fn.executable(path) == 1 then
              return path
            end
            return nil
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
        --[[
        {
          name = 'Attach to gdbserver :1234',
          type = 'cppdbg',
          request = 'launch',
          MIMode = 'gdb',
          miDebuggerServerAddress = 'localhost:1234',
          miDebuggerPath = '/usr/bin/gdb',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'enable pretty printing',
              ignoreFailures = true
            },
          },
        },
        --]]
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
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

  -- Python DAP support plugin
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    config = function()
      local debugpy_location = require("plugins.config.nvim-dap-python.debugpy-location")
      if debugpy_location then
        require("dap-python").setup(debugpy_location)
      end
    end,
  },
}
