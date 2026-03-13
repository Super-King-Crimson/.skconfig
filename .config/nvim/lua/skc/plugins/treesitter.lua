return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.config",
  opts = {
    ensure_installed = {
      "markdown",
      "markdown_inline",
      "c",
      "cpp",
      "bash",
      "make",
      "javascript",
      "typescript",
    },
    auto_install = true,
    highlight = {
      enable = true
    },
  },
}
