return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.config", -- Sets main module to use for opts
  opts = {
    ensure_installed = {
      "markdown_inline",
      "bash",
      "make",
      "c",
    },
    auto_install = true,
    highlight = { enable = true },
  },
}
