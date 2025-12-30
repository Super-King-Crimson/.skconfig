local merge_configs = {
  root_markers = { ".editorconfig" },
}

local capabilities = {}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
  vim.lsp.config(server, { capabilities = capabilities })
  for item, config in pairs(merge_configs) do
    local new_configs = {}

    vim.list_extend(new_configs, config)
    vim.list_extend(new_configs, vim.lsp.config[server][item] or {})

    vim.lsp.config(server, { [item] = new_configs })
  end

  vim.lsp.enable(server)
end
