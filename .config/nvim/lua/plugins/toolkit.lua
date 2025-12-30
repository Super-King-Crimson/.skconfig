return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason-lspconfig.nvim", opts = { automatic_enable = false } },
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
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
      local servers = {
        "ts_ls",
        "rust_analyzer",
        "lua_ls",
        "html",
        "markdown_oxide",
        "eslint",
        "tailwindcss",
      }

      local debuggers = {}

      local linters = {
        "stylua",
        "prettier",
      }

      -- list_extend mutates src, this is a pass-by-reference
      -- we need to keep servers' original state as a table
      -- so mason-lspconfig gets a table of only language servers
      local ensure_installed = debuggers
      vim.list_extend(ensure_installed, servers)
      vim.list_extend(ensure_installed, linters)

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      -- this is just the toolbox: it gives you tools
      -- activate them in config somewhere
    end,
  },
}
