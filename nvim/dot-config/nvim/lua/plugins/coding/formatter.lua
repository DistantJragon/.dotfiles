-- Formatter
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "biome" },
        html = { "biome" },
        java = { "clang-format" },
        javascript = { "biome" },
        json = { "biome" },
        latex = { "latexindent" },
        lua = { "stylua" },
        markdown = { "biome" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
