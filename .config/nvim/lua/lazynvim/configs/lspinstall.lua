return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason.nvim",
      { "j-hui/fidget.nvim", opts = {} },
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
        "markdown-oxide",
      }

      local external_lsp_tools = {
        "godot",
      }

      local tools = {
        "stylua",
        "prettier",
        "gdtoolkit",
      }

      vim.list_extend(tools, lsp_tools)

      require("mason-tool-installer").setup({ ensure_installed = tools })

      vim.list_extend(lsp_tools, external_lsp_tools)
      vim.lsp.enable(lsp_tools)
    end,
  },
  {
    "seblyng/roslyn.nvim",
    dependencies = {
      { "khoido2003/roslyn-filewatch.nvim", opts = {} },
    },
    config = function()
      require("roslyn_filewatch").setup({
        preset = "unity",
      })

      require("roslyn").setup({
        lock_target = true,
        filewatching = "off",
        choose_target = function(targets)
          if #targets == 1 then
            return targets[1]
          end
        end,
      })
    end,
  },
}
