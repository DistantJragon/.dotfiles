M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
if vim.fn.executable("yarn") == 1 then
  -- install with yarn or npm
  M.build = "cd app && yarn install"
  M.init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end
end
return M
