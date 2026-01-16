local map = vim.keymap.set

return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  lazy = false,
  opts = {},
  config = function()
    require("floaterm").setup({
      mappings = {
        term = function(buf)
          map({ "n", "t" }, "<C-p>", function()
            require("floaterm.api").cycle_term_bufs("prev")
          end, { buffer = buf })

          map({ "t", "n" }, "<C-l>", function()
            require("floaterm.api").switch_wins()
          end, { buffer = buf })
        end,
      },
    })

    vim.keymap.set("n", "<Leader>ot", "<cmd>FloatermToggle<CR>", { desc = "[O]pen [T]erminal" })
    vim.keymap.set("t", "<C-f>f", "<cmd>FloatermToggle<CR>")
  end,
}
