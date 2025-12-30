return {
  { -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
      require("mini.sessions").setup()
      require("mini.comment").setup()
      require("mini.files").setup()
      require("mini.starter").setup({
        {
          -- Whether to open Starter buffer on VimEnter. Not opened if Neovim was
          -- started with intent to show something else.
          autoopen = true,

          -- Whether to evaluate action of single active item
          evaluate_single = true,

          -- Items to be displayed. Should be an array with the following elements:
          -- - Item: table with <action>, <name>, and <section> keys.
          -- - Function: should return one of these three categories.
          -- - Array: elements of these three types (i.e. item, array, function).
          -- If `nil` (default), default items will be used (see |mini.starter|).
          items = {},

          -- Header to be displayed before items. Converted to single string via
          -- `tostring` (use `\n` to display several lines). If function, it is
          -- evaluated first. If `nil` (default), polite greeting will be used.
          header = nil,

          -- Footer to be displayed after items. Converted to single string via
          -- `tostring` (use `\n` to display several lines). If function, it is
          -- evaluated first. If `nil` (default), default usage help will be shown.
          footer = nil,

          -- Array  of functions to be applied consecutively to initial content.
          -- Each function should take and return content for Starter buffer (see
          -- |mini.starter| and |MiniStarter.get_content()| for more details).
          content_hooks = nil,

          -- Characters to update query. Each character will have special buffer
          -- mapping overriding your global ones. Be careful to not add `:` as it
          -- allows you to go into command mode.
          query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",

          -- Whether to disable showing non-error feedback
          silent = false,
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
