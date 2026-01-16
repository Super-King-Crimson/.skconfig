return {
  dir = "~/.config/nvim/lua/lazynvim/plugins/lazydev.nvim",
  name = "lazydev",
  ft = "lua",
  config = function()
    require("lazydev").setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },

      integrations = {
        lspconfig = false,
      },
    })
  end,
}
