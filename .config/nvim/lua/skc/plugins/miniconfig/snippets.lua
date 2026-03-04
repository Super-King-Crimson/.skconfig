local gen_loader = require("mini.snippets").gen_loader
local snippets = nil
require("mini.snippets").setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file("~/.config/nvim/snippets/global.json"),

    -- TODO: implement
    gen_loader.from_lang(snippets),
  },

  mappings = {
    expand = "",
    jump_next = "<C-n>",
    jump_prev = "<C-p>",
    stop = "<C-c>",
  }
})

return {}
