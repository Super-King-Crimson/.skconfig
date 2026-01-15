return {
  {
    "seblyng/roslyn.nvim",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason.nvim",
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
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })

      local lsp_tools = {
        "lua-language-server",
        "rust-analyzer",
        "css-variables-language-server",
        "cssmodules-language-server",
        "css-lsp",
        "superhtml",
        "typescript-language-server",
        "roslyn",
        "markdown-oxide",
      }

      local tools = {
        "stylua",
        "prettier",
      }

      vim.list_extend(tools, lsp_tools)

      require("mason-tool-installer").setup({ ensure_installed = tools })

      vim.lsp.enable(lsp_tools)
    end,
  },
}
