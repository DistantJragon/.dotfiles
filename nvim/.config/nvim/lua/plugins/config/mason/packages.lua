-- Python command is either "py" on Linux or "python" on Windows
local python_command = vim.fn.has("win32") == 1 and "python" or "py"
local packages_to_install = {
  -- DAPs
  ["bash-debug-adapter"] = {},
  -- NOTE: cpptools takes ~220 MB
  ["cpptools"] = {},
  ["java-debug-adapter"] = {},
  ["js-debug-adapter"] = {},
  -- No Python DAP, as it is configured in nvim-dap-python, and I honestly don't know how to configure Python debugging
  -- with the executable installed by mason

  -- Linters (configure with nvim-lint)
  ["cpplint"] = { cmds = { python_command } },
  ["cmakelint"] = { cmds = { python_command } },
  ["cspell"] = { cmds = { "npm" } },
  ["htmlhint"] = { cmds = { "npm" } },
  ["checkstyle"] = {},
  ["biome"] = { cmds = { "npm" } },
  ["jsonlint"] = { cmds = { "npm" } },
  ["luacheck"] = { cmds = { "luarocks" } },
  ["markdownlint"] = { cmds = { "npm" } },
  ["shellcheck"] = {},
  ["flake8"] = { cmds = { python_command } },
  ["vint"] = { cmds = { python_command } },

  -- Formatters (configure with formatter.nvim)
  -- clang-format is producing errors when trying to build on my Windows 11 laptop. NOTE: More testing needed
  ["clang-format"] = { cmds = { python_command } },
  ["prettierd"] = { cmds = { "npm" } },
  ["latexindent"] = {},
  ["stylua"] = {},
  ["autoflake"] = { cmds = { python_command } },
  ["isort"] = { cmds = { python_command } },
  ["ruff"] = { cmds = { python_command, "cargo", "rustc" } },
  ["autopep8"] = { cmds = { python_command } },
  ["shfmt"] = {},
  ["beautysh"] = { cmds = { python_command } },

  -- LSPs are configured in mason-lspconfig
}

-- When mason tries to install checkmake on Windows, it says "The current platform is unsupported."
-- Could change in the future, but for now, I guess it's not supported on Windows
if vim.fn.has("win32") == 0 then
  packages_to_install["checkmake"] = {}
end

return packages_to_install
