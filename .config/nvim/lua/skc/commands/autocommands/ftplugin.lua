vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("SKC_mdinject", { clear = true }),
  pattern = { "markdown", "json" },
  callback = function()
    vim.treesitter.start()

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
