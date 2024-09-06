return function(package_table)
  local registry = require("mason-registry")
  local packages_to_install = {}
  local packages_not_found = {}
  for _, tool in ipairs(package_table) do
    if not registry.has_package(tool) then
      table.insert(packages_not_found, tool)
    elseif not registry.is_installed(tool) then
      table.insert(packages_to_install, tool)
    end
  end
  -- local install_handle_list = {}
  for _, pkg_str in ipairs(packages_to_install) do
    -- table.insert(install_handle_list, registry.get_package(pkg_str).install())
    local package_from_registry = registry.get_package(pkg_str)
    _ = package_from_registry:install()
  end
  if #packages_not_found > 0 then
    vim.notify(
      "The following packages are not available in the registry (check spelling):\n"
        .. table.concat(packages_not_found, ", "),
      vim.log.levels.WARN
    )
  end
end
