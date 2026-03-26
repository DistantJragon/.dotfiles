return function(dap)
  -- Languages with no extensions can be added here.
  -- Configure adapters and configurations
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    -- command = "OpenDebugAD7", -- mason should have added this to the path, so it should work (it doesnt?)
    command = vim.fn.exepath("OpenDebugAD7"),
  }
  if vim.fn.has("win32") == 1 then
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

  -- Python

  dap.adapters.python = function(cb, config)
    if config.request == "attach" then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or "127.0.0.1"
      cb({
        type = "server",
        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
        host = host,
        options = {
          source_filetype = "python",
        },
      })
    else
      cb({
        type = "executable",
        command = "debugpy-adapter",
        args = {},
        options = {
          source_filetype = "python",
        },
      })
    end
  end

  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch",
      name = "Launch main",
      console = "integratedTerminal",

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      pythonPath = function()
        local venv = os.getenv("VIRTUAL_ENV")
        local bin_path = vim.fn.has("win32") == 1 and "Scripts" or "bin"
        if venv then
          return venv .. "/" .. bin_path .. "/python"
        end
      end,
      -- program = "${file}", -- This configuration will launch the current file if used.
      program = function()
        -- Check if main.py exists in the current working directory
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/main.py") == 1 then
          return cwd .. "/main.py"
        elseif vim.fn.filereadable(cwd .. "/__init__.py") == 1 then
          return cwd .. "/__init__.py"
        elseif vim.fn.filereadable(cwd .. "/main/__init__.py") == 1 then
          return cwd .. "/main/__init__.py"
        elseif vim.fn.filereadable(cwd .. "/main") == 1 then
          return cwd .. "/main"
        end
      end,
    },
    {
      -- The first three options are required by nvim-dap
      type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch",
      name = "Launch current file",
      console = "integratedTerminal",

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      pythonPath = function()
        local venv = os.getenv("VIRTUAL_ENV")
        local bin_path = vim.fn.has("win32") == 1 and "Scripts" or "bin"
        if venv then
          return venv .. "/" .. bin_path .. "/python"
        end
      end,
      program = "${file}", -- This configuration will launch the current file if used.
    },
    {
      -- The first three options are required by nvim-dap
      type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch",
      name = "Launch file",
      console = "integratedTerminal",

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      pythonPath = function()
        local venv = os.getenv("VIRTUAL_ENV")
        local bin_path = vim.fn.has("win32") == 1 and "Scripts" or "bin"
        if venv then
          return venv .. "/" .. bin_path .. "/python"
        end
      end,
      -- program = "${file}", -- This configuration will launch the current file if used.
      program = function()
        return vim.fn.input("Path to python file: ", vim.fn.getcwd() .. "/", "file")
      end,
    },
  }
end
