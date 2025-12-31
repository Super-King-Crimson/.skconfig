return {
  { -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.indentscope").setup()

      require("mini.sessions").setup()
      require("mini.move").setup()
      require("mini.starter").setup()

      local hipatterns = require("mini.hipatterns")
      local hi_words = require("mini.extra").gen_highlighter.words
      hipatterns.setup({
        highlighters = {
          -- Highlight a fixed set of common words. Will be highlighted in any place,
          -- not like "only in comments".
          fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
          hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
          todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
          note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

          -- Highlight hex color string (#aabbcc) with that color as a background
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      require("mini.files").setup({
        mappings = {
          close = "<Esc>",
          go_in_plus = "<CR>",
          synchronize = "<C-S>",
        },
      })

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
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
