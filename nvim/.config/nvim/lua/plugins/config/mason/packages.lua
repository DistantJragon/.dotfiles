-- Python command is either "py" on Linux or "python" on Windows
local python_command = vim.fn.has("win32") == 1 and "python" or "py"
return {
  -- DAPs
  ["bash-debug-adapter"] = {},
  ["cpptools"] = {},
  ["java-debug-adapter"] = {},
  ["js-debug-adapter"] = {},
  -- No Python DAP, as it is configured in nvim-dap-python, and I honestly don't know how to configure Python debugging
  -- with the executable installed by Mason

  -- Linters (configure with nvim-lint)
  ["cpplint"] = { cmds = { python_command } },
  ["cmakelint"] = { cmds = { python_command } },
  ["cspell"] = { cmds = { "npm" } },
  ["htmlhint"] = { cmds = { "npm" } },
  ["checkstyle"] = {},
  ["biome"] = {},
  ["jsonlint"] = { cmds = { "npm" } },
  ["luacheck"] = { cmds = { "luarocks" } },
  ["checkmake"] = {},
  ["markdownlint"] = { cmds = { "npm" } },
  ["shellcheck"] = {},
  ["flake8"] = { cmds = { python_command } },
  ["vint"] = { cmds = { python_command } },

  -- Formatters (configure with formatter.nvim)
  ["clang-format"] = { cmds = { python_command } },
  ["prettierd"] = { cmds = { "npm" } },
  ["latexindent"] = {},
  ["stylua"] = {},
  ["autoflake"] = { cmds = { python_command } },
  ["isort"] = { cmds = { python_command } },
  ["ruff"] = { cmds = { python_command } },
  ["autopep8"] = { cmds = { python_command } },
  ["shfmt"] = {},
  ["beautysh"] = { cmds = { python_command } },

  -- LSPs are configured in mason-lspconfig
}
