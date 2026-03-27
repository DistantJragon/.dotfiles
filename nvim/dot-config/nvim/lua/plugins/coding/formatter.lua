-- Formatter
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clangformat" },
        cpp = { "clangformat" },
        css = { "biome" },
        html = { "biome" },
        java = { "clangformat" },
        javascript = { "biome" },
        json = { "biome" },
        latex = { "latexindent" },
        lua = { "stylua" },
        markdown = { "biome" },
        python = { "ruff-format" },
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
