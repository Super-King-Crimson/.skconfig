return { -- Collection of various small independent plugins/modules
  "nvim-mini/mini.nvim",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = false,
  config = function()
    require("mini.ai").setup({ n_lines = 500 })

    require("mini.comment").setup()
    require("mini.indentscope").setup()
    require("mini.move").setup()

    require("skc/plugins/miniconfig/hipatterns")
    require("skc/plugins/miniconfig/files")
    require("skc/plugins/miniconfig/snippets")

    require("mini.pairs").setup({
      modes = { command = true },
      mappings = {
        ['"'] = false,
        ["'"] = false,
        ["`"] = false,
      },
    })

    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = vim.g.have_nerd_font })
    statusline.section_location = function() return "%2l:%-2v" end
  end,
}
