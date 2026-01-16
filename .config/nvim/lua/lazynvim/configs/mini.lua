return { -- Collection of various small independent plugins/modules
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.indentscope").setup()
    require("mini.move").setup()

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

    local MiniFiles = require("mini.files")

    MiniFiles.setup({
      mappings = {
        close = "<Esc>",
        go_in_plus = "<CR>",
        synchronize = "<C-S>",
      },
    })

    local function miniFileToggle(from_current_buffer)
      if require("mini.files") == nil then
        return
      end

      local variant = from_current_buffer
          and function()
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
          end
        or function()
          MiniFiles.open(nil, false)
        end

      if MiniFiles.get_explorer_state() then
        MiniFiles.close()
      else
        variant()
      end
    end

    vim.keymap.set({ "", "i" }, "<C-l>", function()
      miniFileToggle(true)
    end, { desc = "Explore directory of [l]ocal buffer" })

    vim.keymap.set({ "", "i" }, "<C-e>", function()
      miniFileToggle()
    end, { desc = "[E]xplore current directory" })

    vim.keymap.set("n", "ss", function()
      vim.cmd("tab sp")
      miniFileToggle(true)
    end)

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
}
