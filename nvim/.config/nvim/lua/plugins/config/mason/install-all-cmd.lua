return function(package_tables)
  local registry = require("mason-registry")
  local packages_to_install = ""
  local failed_packages = {}
  for _, package_table in ipairs(package_tables) do
    for _, package in ipairs(package_table) do
      if not registry.has_package(package) then
        table.insert(failed_packages, package)
      else if not registry.is_installed(package) then
          packages_to_install = packages_to_install .. " " .. package
        end
      end
    end
  end
  if packages_to_install ~= "" then
    packages_to_install = packages_to_install:sub(2)
    vim.cmd("MasonInstall " .. packages_to_install)
  end
  if #failed_packages > 0 then
    vim.notify(
      "The following packages are not available in the registry (check spelling): " ..
      table.concat(failed_packages, ", "),
      vim.log.levels.WARN
    )
  end
end

