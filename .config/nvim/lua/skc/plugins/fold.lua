return {
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("origami").setup({
        useLspFoldsWithTreesitterFallback = {
          enabled = true,
          foldmethodIfNeitherIsAvailable = "indent",
        },
        pauseFoldsOnSearch = true,
        foldtext = {
          enabled = true,
          padding = 3,
          lineCount = {
            template = "%d lines", -- `%d` is replaced with the number of folded lines
            hlgroup = "Comment",
          },
          diagnosticsCount = true,
          gitsignsCount = true,
          disableOnFt = { "snacks_picker_input" },
        },
        autoFold = {
          enabled = true,
          kinds = { "imports" },
        },
        foldKeymaps = {
          setup = false,
          closeOnlyOnFirstColumn = false,
          scrollLeftOnCaret = false,
        },
      })

      vim.keymap.set("n", "h", function() require("origami").h() end)
      vim.keymap.set("n", "l", function() require("origami").l() end)
      vim.keymap.set("n", "gh", function() require("origami").caret() end)
      vim.keymap.set("n", "gl", function() require("origami").dollar() end)
    end
  },
}
