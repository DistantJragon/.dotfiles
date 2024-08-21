local debugpy_location = vim.fn.stdpath("data") .. "/debugpy/bin/python"
local ignore_debugpy_error = false
if vim.fn.has("win32") == 1 then
  debugpy_location = vim.fn.stdpath("data") .. "/debugpy/Scripts/python.exe"
end
-- debugpy_location = "Uncomment this line and write the path to the debugpy executable here if you don't want debugpy in nvim's data folder"
if vim.fn.executable(debugpy_location) == 0 then
  if not ignore_debugpy_error then
    vim.notify(
      "Debugpy not found at "
        .. debugpy_location
        .. "\nPlease create a virtual environment and install debugpy with pip in "
        .. vim.fn.stdpath("data")
        .. "\nYou won't be able to debug python code in neovim until this is resolved."
        .. "\nYou can suppress this message by setting ignore_debugpy_error = true in "
        .. vim.fn.stdpath("config")
        .. "lua/utils/debugpy-location.lua"
        .. "\nCommands:"
        .. "\npython -m venv "
        .. vim.fn.stdpath("data")
        .. "/debugpy ; "
        .. vim.fn.stdpath("data")
        .. "/debugpy/bin/python -m pip install debugpy"
        .. "\n",
      vim.log.levels.WARN
    )
  end
  debugpy_location = ""
end

return debugpy_location
