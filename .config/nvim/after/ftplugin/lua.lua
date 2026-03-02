local function onInit(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name

    if path ~= vim.fn.stdpath('config') then
      if (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end
  end

  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    runtime = {
      version = 'LuaJIT',
      path = {
        'lua/?.lua',
        'lua/?/init.lua',
      },
    },

    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME,
        '${3rd}/luv/library',
        -- '${3rd}/busted/library',
      },
      -- Or pull in all of 'runtimepath'.
      -- NOTE: this is a lot slower and will cause issues when working on
      -- your own configuration.
      -- See https://github.com/neovim/nvim-lspconfig/issues/3189
      -- library = vim.api.nvim_get_runtime_file('', true),
    },
  })
end

vim.lsp.config('lua-language-server', {
  on_init = onInit,
})

vim.bo.shiftwidth = 2
vim.bo.expandtab = true
