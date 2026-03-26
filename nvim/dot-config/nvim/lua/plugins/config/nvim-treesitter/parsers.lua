local parsers = {
  "asm",
  "bash",
  "c",
  "comment",
  "cpp",
  "css",
  "diff",
  "gitcommit",
  "gitignore",
  "html",
  "http",
  "java",
  "javascript",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "sql",
  "vim",
  "vimdoc",
  "xml",
}

if vim.fn.executable("tree-sitter") == 1 then
  table.insert(parsers, "latex")
end

return parsers
