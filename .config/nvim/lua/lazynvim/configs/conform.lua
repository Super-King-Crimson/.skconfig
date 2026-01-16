return { -- autoformatting
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>wf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[W]rite buffer [F]ormatted",
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { "stylua" },
      html = { "superhtml" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      css = { "prettier" },
    },

    format_on_save = function(bufnr)
      local disable_filetypes = {
        c = true,
        cpp = true,
      }

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
  },
}
