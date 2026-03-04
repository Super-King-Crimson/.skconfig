local LabTools = require("labtools")
local fuzzyFindPrompt = LabTools.fuzzyFindPrompt
local logMsg = LabTools.logMsg
local isEmpty = LabTools.isEmpty
local trim = LabTools.trim

local SCRATCH_WIN_NAME = "[Scratch]"

local enum = {
  float = "float",
  docktop = "docktop",
  dockbottom = "dockbottom",
  dockleft = "dockleft",
  dockright = "dockright",
}

local map = {
  docktop    = "above",
  dockbottom = "below",
  dockleft   = "left",
  dockright  = "right"
}

local FLOATERS = {}

local FLOATING_RECENCY_LIST = {}
FLOATING_RECENCY_LIST._head = nil
FLOATING_RECENCY_LIST._tail = nil

local DOCKED = {}

local WINDOW_FLOATING = false
local currentFloatingWindow = ""
local lastAccessedWindow = ""

local DEFAULT_OPTS = {
  width = 0.8,
  height = 0.8,
  size = 15,
  style = enum.float,
}

local DEFAULT_DIRECTION = enum.dockleft

-- increments by one until valid number found
-- needs to exist so that if a dock becomes a floating winow,
-- we're able to make a new one without overriding the dock
local function getValidName()
  local name = SCRATCH_WIN_NAME
  local i = 1

  while FLOATERS[name] ~= nil do
    name = string.format("%s (%d)", SCRATCH_WIN_NAME, i)
    i = i + 1
  end

  return name
end

-- creates default win opts
local function newWinOpts(opts)
  if not opts then opts = {} end

  local self = {
    height = opts.height or DEFAULT_OPTS.height,
    width = opts.width or DEFAULT_OPTS.width,
    size = opts.size or DEFAULT_OPTS.size,

    bufnr = -1,
    winid = -1,

    style = opts.style or DEFAULT_OPTS.style,

    -- magnitude is used, negative greatest magnitude will get window focus (if all positive, no winfocus change)
    -- lower number means it will be split earlier than docks of same style
    order = 0,
  }

  return self
end

-- defaults to current winbuffer if winid not provided
local function isManagedWinid(winid)
  if not winid then winid = vim.api.nvim_get_current_win() end

  for winname, _ in pairs(DOCKED) do
    if FLOATERS[winname].winid == winid then return winname end
  end

  if FLOATERS[currentFloatingWindow] then
    if winid == FLOATERS[currentFloatingWindow].winid then
      return currentFloatingWindow
    end
  end

  return nil
end

-- for a window name, will return its style if it is valid
local function getDisplayType(name)
  name = name or currentFloatingWindow

  if isEmpty(name) or name == currentFloatingWindow then
    return WINDOW_FLOATING and enum.float or nil
  end

  for winname, _ in pairs(DOCKED) do
    if winname == name then
      return vim.api.nvim_win_is_valid(FLOATERS[winname].winid) and FLOATERS[winname].style or nil
    end
  end

  return nil
end

local function updateRecencyList(winName)
  local fart = FLOATING_RECENCY_LIST

  if fart._head == nil then
    fart._head = winName
    fart._tail = winName
  end

  fart[winName] = {
    prev = fart._head,
    next = fart._tail,
  }

  fart[fart._head].next = winName
  fart[fart._tail].prev = winName
  fart._head = winName
end

-- does nothing if is not floating window, feel free to call as much as you want
local function removeFromRecencyList(winname)
  -- TODO
end

-- accepts a window with an attached buffer, and creates a floating window for it
local function attachFloatWindow(winopts)
  winopts.style = enum.float

  local lines = math.floor(vim.o.lines * winopts.height)
  local cols = math.floor(vim.o.columns * winopts.width)

  -- Calculate the position to center the window
  local line = math.floor((vim.o.lines - lines) / 2)
  local col = math.floor((vim.o.columns - cols) / 2)

  -- Define window configuration
  local win_config = {
    relative = "editor",
    height = lines,
    width = cols,
    row = line,
    col = col,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  if vim.api.nvim_win_is_valid(winopts.winid) then vim.api.nvim_win_hide(winopts.winid) end

  winopts.winid = vim.api.nvim_open_win(winopts.bufnr, true, win_config)
end

local function closeCurrentFloating()
  if not WINDOW_FLOATING then return end

  if vim.api.nvim_win_is_valid(FLOATERS[currentFloatingWindow].winid) then
    vim.api.nvim_win_hide(FLOATERS[currentFloatingWindow].winid)
  end

  WINDOW_FLOATING = false
end

-- if passed a winname that is docked, will transform it into a floating window
-- empty string or null defaults to current floating window
-- if no current floating window, will make a new valid one
-- places the window buffer last in recency list
local function toggleFloatWindow(name)
  if WINDOW_FLOATING == true then
    logMsg("closing " .. currentFloatingWindow)

    closeCurrentFloating()
    if isEmpty(name) or name == currentFloatingWindow then return end
  end

  if isEmpty(currentFloatingWindow) then currentFloatingWindow = name or getValidName() end
  if isEmpty(name) then name = currentFloatingWindow end

  logMsg("making window " .. name)

  if not FLOATERS[name] then
    logMsg("creating new floater " .. name)
    local bufnr = vim.api.nvim_create_buf(false, true)

    local winopts = newWinOpts()
    winopts.bufnr = bufnr
    FLOATERS[name] = winopts

    updateRecencyList(name)
  end

  attachFloatWindow(FLOATERS[name])
  currentFloatingWindow = name
  lastAccessedWindow = name
  WINDOW_FLOATING = true

  logMsg("current float: " .. currentFloatingWindow)
end

local function closeCurrentlyDocked(name)
  if name == nil or DOCKED[name] == nil then return end

  vim.api.nvim_win_hide(FLOATERS[name].winid)
  DOCKED[name] = nil
end

-- like attachFloatWindow, but for dock
-- optionally accepts a splitwinid to start the split from, and a style for where to put the win
local function attachDockWindow(winopts, splitwinid, style)
  if winopts.style == enum.float or style ~= nil then
    winopts.style = style or DEFAULT_DIRECTION
  end

  local win_config = {
    win = splitwinid or 0,
    split = map[winopts.style]
  }

  if vim.api.nvim_win_is_valid(winopts.winid) then vim.api.nvim_win_hide(winopts.winid) end

  winopts.winid = vim.api.nvim_open_win(winopts.bufnr, false, win_config)
end

-- similar to toggleFloatWindow but instead creates a docked window
-- optionally accepts a style (not enum.float)
-- if passed a winname that is floating, will transform it into a docked window (with default dock)
-- NOTE: if this happens it will be removed from recency list
-- empty string or null defaults to current floating window
-- if no current floating window, will make a new valid one
local function toggleDockWindow(name, style)
  if style == enum.float then error("float is not a valid dock style.") end

  if not isEmpty(name) and DOCKED[name] then
    closeCurrentlyDocked(name)
    return
  end

  if isEmpty(name) then name = getValidName() end

  if not FLOATERS[name] then
    logMsg("creating new dock " .. name)
    local bufnr = vim.api.nvim_create_buf(false, true)

    local winopts = newWinOpts()
    winopts.bufnr = bufnr
    FLOATERS[name] = winopts
  end

  if name == currentFloatingWindow then
    closeCurrentFloating()
    currentFloatingWindow = ""
    removeFromRecencyList(currentFloatingWindow)
  end

  lastAccessedWindow = name
  attachDockWindow(FLOATERS[name], 0, style)
  DOCKED[name] = true
end

local function closeAllWindows()
  closeCurrentFloating()

  for name, _ in pairs(DOCKED) do
    closeCurrentlyDocked(name)
  end
end

-- hey export this one too
local function deleteWindow(name)
  if isEmpty(name) then name = currentFloatingWindow end

  if FLOATERS[name] == nil then return end

  if name == currentFloatingWindow then
    currentFloatingWindow = ""
  end

  removeFromRecencyList(name)

  local winid = FLOATERS[name].winid
  if vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_win_hide(winid)
  end

  FLOATERS[name] = nil
  DOCKED[name] = nil
end

-- autoredirects based on style. (maybe export this one?)
local function toggleFloat(name, style)
  -- if no name provided, use name of current buffer
  -- if that isn't managed either, just make a new buffer
  if isEmpty(name) then
    local validWin = isManagedWinid()

    if validWin then name = validWin end
  end

  if isEmpty(style) then
    if not isEmpty(name) and FLOATERS[name] then
      style = FLOATERS[name].style
    else
      style = DEFAULT_OPTS.style
    end
  end

  -- if we can't find name from that, we at least have a style, so default options for that
  if style == enum.float then
    toggleFloatWindow(name)
  else
    toggleDockWindow(name, style)
  end
end

local function toggleFloatFromFuzzy()
  local floaters = vim.tbl_keys(FLOATERS)

  fuzzyFindPrompt(floaters, function(item)
    toggleFloat(item)
  end)
end

local function toggleFloatFromInput()
  vim.ui.input({ prompt = "Window name: " }, function(input)
    if input == nil then return end

    input = trim(input)
    if isEmpty(input) then input = SCRATCH_WIN_NAME end

    if string.sub(input, 1, 1) == "_" then
      logMsg("Please provide a valid window name (no leading underscores allowed)")
      return
    end

    toggleFloat(input)
  end)
end

local function togglePrevWindow()
  toggleFloat(FLOATING_RECENCY_LIST[currentFloatingWindow].prev)
end

local function toggleNextWindow()
  toggleFloat(FLOATING_RECENCY_LIST[currentFloatingWindow].next)
end

local function toggleLastWindow()
  toggleFloat(FLOATING_RECENCY_LIST._tail)
end

local function toggleFirstWindow()
  toggleFloat(FLOATING_RECENCY_LIST._head)
end

local function swapCurrentFloatType()
  local name = isManagedWinid()

  if name == nil then
    logMsg("you are not in a float!")
    return
  end

  local winopts = FLOATERS[name]

  if winopts.style == enum.float then
    winopts.style = DEFAULT_DIRECTION
  end

  if winopts.style == enum.float then
    toggleFloatWindow(name)
  else
    toggleDockWindow(name)
  end
end

vim.keymap.set("n", "<Leader>O", toggleFloat, { desc = "[O]pen last floater" })
vim.keymap.set("n", "<Leader>of", toggleFloatFromFuzzy, { desc = "[O]pen [F]loater" })
vim.keymap.set("n", "<Leader>on", toggleFloatFromInput, { desc = "[O]pen [N]ew floater" })

vim.keymap.set("n", "<Leader>oh", swapCurrentFloatType, { desc = "[O]h [H]ell no" })

local group = vim.api.nvim_create_augroup("SKC_FloatLifecycle", { clear = true })

vim.api.nvim_create_autocmd({ "WinResized" }, {
  group = group,
  callback = function()
    for _, winid in ipairs(vim.v.event.windows) do
      if isManagedWinid(winid) then
        logMsg(string.format("Managed window %s resized to %d", isManagedWinid(winid), vim.api.nvim_win_get_width(winid)))
      end
    end
  end,
  desc = "Allows split windows to persist across tabs",
})

vim.keymap.set("i", "<C-p>", togglePrevWindow)
vim.keymap.set("i", "<C-n>", toggleNextWindow)
