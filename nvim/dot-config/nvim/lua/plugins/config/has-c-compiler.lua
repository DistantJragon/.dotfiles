return vim.fn.executable("cc") == 1
  or vim.fn.executable("gcc") == 1
  or vim.fn.executable("clang") == 1
  or vim.fn.executable("cl") == 1
  or vim.fn.executable("zig") == 1
