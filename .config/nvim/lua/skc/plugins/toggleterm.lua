local map = vim.keymap.set

local function getHeight()
  return math.floor(vim.o.lines * 0.8)
end

local function getWidth()
  return math.floor(vim.o.columns * 0.8)
end

local function putInRange(number, min, max)
  if min == max then
    return min
  elseif min > max then
    min, max = max, min
  end

  local range = max - min + 1
  return min + (math.abs(number) % range)
end

return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  config = function()
    ---@diagnostic disable-next-line
    require("toggleterm").setup({
      open_mapping = "<C-9>",
      insert_mappings = false,
      start_in_insert = false,
      terminal_mappings = false,
      direction = "float",
      float_opts = {
        border = "rounded",
        winblend = 10,
        zindex = 10,
        title_pos = "right",
        height = getHeight,
        width = getWidth,
      },
    })

    local namedBuffers = {
      "main",
      "runner",
      "scratch",
    }

    local currTerm = 1
    local activeBuffers = {}

    local function inRange(num)
      return putInRange(num, 1, 3)
    end

    local function toggleTerminal()
      vim.cmd(currTerm .. "ToggleTerm name=" .. namedBuffers[currTerm])

      if vim.api.nvim_get_mode() ~= "t" then
        vim.api.nvim_input("i")
      end

      if vim.bo.buftype ~= "terminal" then
        vim.api.nvim_input("<Esc>")
      end
    end

    local function prevTerminal()
      currTerm = inRange(currTerm - 1)
      toggleTerminal()
    end

    local function nextTerminal()
      currTerm = inRange(currTerm + 1)
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
