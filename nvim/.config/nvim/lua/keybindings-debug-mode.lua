local original_keymaps = {
  n = vim.api.nvim_get_keymap("n"),
  i = vim.api.nvim_get_keymap("i"),
  v = vim.api.nvim_get_keymap("v"),
}

local debug_keymappings = {
  b = { bind = ':lua require("dap").toggle_breakpoint()<CR>', desc = "Toggle breakpoint" },
  B = {
    bind = ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    desc = "Set breakpoint condition",
  },
  m = {
    bind = ':lua require("dap").set_breakpoint({ nil, nil, vim.fn.input("Log point message: ") })<CR>',
    desc = "Set log point",
  },
  c = { bind = ':lua require("dap").continue()<CR>', desc = "Continue (Debug)" },
  n = { bind = ':lua require("dap").step_over()<CR>', desc = "Step over [next] (Debug)" },
  si = { bind = ':lua require("dap").step_into()<CR>', desc = "Step into (Debug)" },
  so = { bind = ':lua require("dap").step_out()<CR>', desc = "Step out (Debug)" },
  vh = { bind = ':lua require("dap.ui.variables").hover()<CR>', desc = "Hover Variables" },
  vvh = { bind = ':lua require("dap.ui.variables").visual_hover()<CR>', desc = "Visual Hover Variables" },
  vs = { bind = ':lua require("dap.ui.variables").scopes()<CR>', desc = "Scopes" },
  w = {
    bind = ':lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)<CR>',
    desc = "Scopes",
  },
  ro = { bind = ':lua require("dap").repl.open()<CR>', desc = "Open REPL" },
}

local function debug_mode_activate()
  for key, value in pairs(debug_keymappings) do
    vim.keymap.set("n", key, value.bind, { silent = true, desc = value.desc })
  end
end

local function debug_mode_deactivate()
  for key, value in pairs(debug_keymappings) do
    if original_keymaps.n[key] then
      vim.keymap.set("n", key, original_keymaps.n[key].rhs, original_keymaps.n[key])
    else
      vim.keymap.del("n", key)
    end
  end
end

vim.keymap.set("n", "<Leader>db", function()
  vim.g.djn_debug_mode = not vim.g.djn_debug_mode
  if vim.g.djn_debug_mode then
    require("dapui").open()
    debug_mode_activate()
  else
    require("dapui").close()
    debug_mode_deactivate()
  end
end, { desc = "Toggle Debug Mode" })

vim.keymap.set("n", "<Leader>ddb", function()
  vim.g.djn_debug_mode = not vim.g.djn_debug_mode
end, { desc = "Toggle Debug Mode global variable" })
