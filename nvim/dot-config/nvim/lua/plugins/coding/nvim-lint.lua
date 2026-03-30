return {
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
        end,
      })
      -- The rest of the linters can be run when the buffer is changed
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = function()
          local ft_stdin = { "latex", "html", "json", "python", "lua", "ps1", "sh" }
          local ft = vim.bo.filetype
          if ft_stdin[ft] then
            require("lint").try_lint()
          end
          require("lint").try_lint("cspell")
        end,
      })
    end,
    config = function()
      require("lint").linters_by_ft = {
        cmake = { "cmakelint" },
        html = { "htmlhint" },
        java = { "checkstyle" },
        json = { "jsonlint" },
        latex = { "chktex" },
        make = { "checkmake" },
        markdown = { "markdownlint" },
        ps1 = { "shellcheck" },
        sh = { "shellcheck" },
        vim = { "vint" },
      }
    end,
  }
}
