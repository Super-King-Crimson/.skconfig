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
          enabled = false,
          kinds = { "imports" },
        },
        foldKeymaps = {
          setup = false,
          closeOnlyOnFirstColumn = true,
          scrollLeftOnCaret = false,
        },
      })
    end
  },
}
