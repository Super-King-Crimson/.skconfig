return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.config", -- Sets main module to use for opts
  opts = {
    auto_install = true,
    highlight = { enable = true },
  },
}
