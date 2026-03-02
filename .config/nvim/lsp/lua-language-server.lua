---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },

  root_markers = {
    "stylua.toml",
    "init.lua"
  },

  settings = {
    Lua = {
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        semicolon = "Disable",
      },
    }
  },
}
