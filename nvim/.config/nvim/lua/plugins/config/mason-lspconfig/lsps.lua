-- Python command is either "py" on Linux or "python" on Windows
local python_command = vim.fn.has("win32") == 1 and "python" or "py"
return {
  -- Assembly
  ["asm_lsp"] = { cmds = { "cargo" } },
  -- Python
  ["basedpyright"] = { cmds = { python_command } },
  -- Bash
  ["bashls"] = { cmds = { "npm" } },
  -- JavaScript
  ["biome"] = { cmds = { "npm" } },
  -- C/C++
  ["clangd"] = {},
  -- CMake
  ["cmake"] = { cmds = { python_command } },
  -- CSS
  ["css_variables"] = { cmds = { "npm" } },
  ["cssls"] = { cmds = { "npm" } },
  ["cssmodules_ls"] = { cmds = { "npm" } },
  -- Docker
  ["docker_compose_language_service"] = { cmds = { "npm" } },
  ["dockerls"] = { cmds = { "npm" } },
  -- HTML/HTMX
  ["html"] = { cmds = { "npm" } },
  ["htmx"] = { cmds = { "cargo" } },
  -- Java
  ["java_language_server"] = { cmds = { "jlink", "mvn" } },
  -- JSON
  ["jsonls"] = { cmds = { "npm" } },
  -- LaTeX
  ["ltex"] = {},
  -- Lua
  ["lua_ls"] = {},
  -- Markdown
  ["marksman"] = {},
  -- PowerShell
  ["powershell_es"] = {},
  -- Rust
  ["rust_analyzer"] = {},
  -- Spell checking
  ["typos_lsp"] = {},
  -- Vim
  ["vimls"] = { cmds = { "npm" } },
}
