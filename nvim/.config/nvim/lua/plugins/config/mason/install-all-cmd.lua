return function(package_table)
  local registry = require("mason-registry")
  local packages_to_install = {}
  local failed_packages = {}
  for _, tool in ipairs(package_table) do
    if not registry.has_package(tool) then
      table.insert(failed_packages, tool)
    elseif not registry.is_installed(tool) then
      table.insert(packages_to_install, tool)
    end
  end
  if #packages_to_install > 0 then
    local package_string = table.concat(packages_to_install, " ")
    vim.cmd("MasonInstall " .. package_string)
  end
  if #failed_packages > 0 then
    vim.notify(
      "The following packages are not available in the registry (check spelling):\n"
        .. table.concat(failed_packages, ", "),
      vim.log.levels.WARN
    )
  end
end
