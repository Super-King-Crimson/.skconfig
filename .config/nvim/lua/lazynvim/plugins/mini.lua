return {
  { -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
      require("mini.comment").setup()

      require("mini.sessions").setup()

      require("mini.files").setup({
        mappings = {
          close = "<Esc>",
          go_in_plus = "<CR>",
          synchronize = "<C-S>",
        },
      })

      require("mini.pairs").setup({
        mappings = {
          ['"'] = false,
          ["'"] = false,
          ["`"] = false,
        },
      })

      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
