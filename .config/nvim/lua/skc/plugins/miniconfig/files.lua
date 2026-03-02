local IGNORE_FILES = {
  ".cs.meta",
  ".cs.uid",
  ".meta",
  ".asset",
  ".asset.meta",
}

local function miniFileToggle(from_current_buffer)
  if require("mini.files") == nil then
    return
  end

  local variant = from_current_buffer
      and function() MiniFiles.open(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h"), false) end
      or function() MiniFiles.open(nil, false) end

  if MiniFiles.get_explorer_state() then
    MiniFiles.close()
  else
    if not pcall(variant) then
      MiniFiles.open(nil, false)
    end
  end
end

local MiniFiles = require("mini.files")

MiniFiles.setup({
  content = {
    filter = function(fs_entry)
      for _, banned in ipairs(IGNORE_FILES) do
        if string.match(fs_entry.name, banned) then
          return false
        end
      end

      return true
    end,
  },
  mappings = {
    close = "<Esc>",
    reset = ";",
    go_in_plus = "<CR>",
    synchronize = "<C-S>",
  },
})

-- so many keymaps...
vim.keymap.set({ "", "i" }, "<C-l>", function()
  miniFileToggle(true)
end, { desc = "Explore directory of [l]ocal buffer" })

vim.keymap.set({ "", "i" }, "<C-d>", function()
  miniFileToggle()
end, { desc = "Explore current directory" })

vim.keymap.set("n", "<LocalLeader><LocalLeader>l", function()
  vim.cmd("tab sp")
  miniFileToggle(true)
end, { desc = "Explore local directory in new tab" })

vim.keymap.set("n", "<LocalLeader><LocalLeader>d", function()
  vim.cmd("tab sp")
  miniFileToggle()
end, { desc = "Explore current directory in new tab" })

return {}
