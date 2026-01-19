---@diagnostic disable all
local map = vim.keymap.set

return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  config = function()
    local function getHeight()
      return math.floor(vim.o.lines * 0.8)
    end

    local function getWidth()
      return math.floor(vim.o.columns * 0.8)
    end

    ---@diagnostic disable-next-line
    require("toggleterm").setup({
      open_mapping = "<C-9>",
      insert_mappings = false,
      start_in_insert = false,
      terminal_mappings = false,
      direction = "float",
      float_opts = {
        border = "rounded",
        winblend = 30,
        zindex = 10,
        title_pos = "right",
        height = getHeight,
        width = getWidth,
      },
    })

    local thisIsStupid = {
      "main",
      "runner",
      "scratch",
    }

    local currTerm = 1

    local function rangeify(num)
      if num > 3 then
        return 1
      elseif num < 1 then
        return 3
      end

      return num
    end

    local function toggleTerminal()
      vim.cmd(currTerm .. "ToggleTerm name=" .. thisIsStupid[currTerm])

      if vim.api.nvim_get_mode() ~= "t" then
        vim.api.nvim_input("i")
      end

      if vim.bo.buftype ~= "terminal" then
        vim.api.nvim_input("<Esc>")
      end
    end

    local function prevTerminal()
      currTerm = rangeify(currTerm - 1)
      toggleTerminal()
    end
    local function nextTerminal()
      currTerm = rangeify(currTerm + 1)
      toggleTerminal()
    end

    function _G.setTerminalKeymaps()
      local opts = { buffer = 0 }
      map("t", "<C-o>", toggleTerminal, opts)
      map("t", "<C-j>", prevTerminal, opts)
      map("t", "<C-k>", nextTerminal, opts)
    end

    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua setTerminalKeymaps()")

    map("n", "<Leader>ot", toggleTerminal, { desc = "[O]pen [T]erminal", remap = true })
  end,
}
