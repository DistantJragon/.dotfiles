return function(packages_to_check)
  local packages_to_install = {}

  local commands = {
    node = { site = "https://nodejs.org/en/download" },
  }
  for _, cmd in pairs(commands) do
    cmd.dependent_tools = {}
  end

  for tool_name, tool in pairs(packages_to_check) do
    if not tool.cmds then
      -- If tool has no required command, add it to the list of tools to install
      table.insert(packages_to_install, tool_name)
    else
      -- If tool has required commands, add it to the command list
      for _, cmd in ipairs(tool.cmds) do
        if not commands[cmd] then
          commands[cmd] = { dependent_tools = {} }
        end
        table.insert(commands[cmd].dependent_tools, tool_name)
      end
    end
  end

  local missing_command_string = "Your machine is missing the command [ %s ].\n"
  local missing_package_string = "As such, the following tools are unable to be installed:\n%s\n"
  local more_info_site_string = "Please visit %s for more information on how to install the required program.\n"
  local full_vim_notify_string = ""

  for cmd, cmd_info in pairs(commands) do
    if not vim.fn.executable(cmd) then
      full_vim_notify_string = full_vim_notify_string .. string.format(missing_command_string, cmd)
      if #cmd_info.dependent_tools > 0 then
        local dependent_tools_string = table.concat(cmd_info.dependent_tools, ", ")
        full_vim_notify_string = full_vim_notify_string .. string.format(missing_package_string, dependent_tools_string)
      end
      if cmd_info.site then
        full_vim_notify_string = full_vim_notify_string .. string.format(more_info_site_string, cmd_info.site)
      end
    else
      for _, tool_name in ipairs(cmd_info.dependent_tools) do
        table.insert(packages_to_install, tool_name)
      end
    end
  end

  if full_vim_notify_string ~= "" then
    vim.notify(full_vim_notify_string, vim.log.levels.WARN)
  end
end
