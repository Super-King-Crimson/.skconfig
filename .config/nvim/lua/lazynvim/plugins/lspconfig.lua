return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
      { "mason-org/mason.nvim", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        lua_ls = {
          root_markers = { ".editorconfig", ".stylua.toml", ".git" },
        },
        superhtml = {},
        cssls = {},
        ts_ls = {},
      }

      local debuggers = {}

      -- and formatters
      local linters = {
        "stylua",
        "prettier",
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, debuggers)
      vim.list_extend(ensure_installed, linters)

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      local masonlspconfig = require("mason-lspconfig")
      masonlspconfig.setup({
        ensure_installed = {},
        automatic_enable = false,
      })

      for _, server_name in ipairs(masonlspconfig.get_installed_servers()) do
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
