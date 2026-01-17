local SESSION_DIR = "/home/skc/Documents/nvimsessions/"
local defaultSessionName = "latest"
local currSession = nil
local silent = false
local debugMode = false

-- for a function a bit down don't worry abt it
local pickers
local finders
local conf
local actions
local action_state

local function logMsg(msg, logLevel)
  if silent then
    return
  end

  vim.notify(msg, logLevel or vim.log.levels.INFO)
end

local function logDebug(debugMsg, logLevel)
  if debugMode then
    logMsg("DEBUG: " .. debugMsg, logLevel)
  end
end

local function sessionNameToFullPath(name)
  local path = SESSION_DIR .. name

  return path .. ".vim"
end

local function fullPathToSessionName(path)
  local relPath = vim.fn.slice(path, vim.fn.strcharlen(SESSION_DIR))
  return vim.fn.fnamemodify(relPath, ":r")
end

local function tableContains(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local function writeAutosession(name)
  if name == nil or name == "" or name == vim.NIL then
    error("provide a session name")
    return
  end

  local sessionPath = sessionNameToFullPath(name)

  local parentDir = vim.fn.fnamemodify(sessionPath, ":h")
  local dirExists = vim.fn.isdirectory(parentDir) == 1

  if not dirExists then
    logDebug(parentDir .. " doesn't exist, initializing")
    vim.cmd("silent !mkdir -p " .. parentDir)
  end

  -- sorry we can't ever save the terminals might as well keep a clean slate between wkspaces
  vim.cmd("silent mksession! " .. sessionPath)

  if not silent then
    logDebug("Wrote session" .. sessionPath, vim.log.levels.INFO)
  end

  return sessionPath
end

local function changeWriteAutoSession(name)
  if name == nil or name == "" or name == vim.NIL then
    error("provide a valid session name")
  end

  currSession = name
  return writeAutosession(name)
end

local function getAutosessions()
  local sessions = vim.fn.glob(SESSION_DIR .. "**/*.vim", true, true)
  local sessionNames = {}

  for i, sessionPath in ipairs(sessions) do
    sessionNames[i] = fullPathToSessionName(sessionPath)
  end

  return sessionNames
end

local function loadAutosession(sessionName)
  if sessionName == nil or sessionName == "" or sessionName == vim.NIL then
    error("session should not be nil")
  end

  local sessionIsValid = tableContains(getAutosessions(), sessionName)
  if not sessionIsValid then
    error(sessionName .. " is not a valid session name")
  end

  currSession = sessionName

  vim.cmd("silent! %bwipeout!")
  vim.cmd("silent! source " .. sessionNameToFullPath(sessionName))
  logMsg("Successfully sourced " .. sessionName, vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "telescope.nvim" then
      pickers = require("telescope.pickers")
      finders = require("telescope.finders")
      conf = require("telescope.config").values
      actions = require("telescope.actions")
      action_state = require("telescope.actions.state")
    end
  end,
})

local function fuzzyFindPrompt(items, callback)
  if #items == 0 then
    error("There are no autosessions")
  end

  if not pickers then
    error("You must have telescope installed to fuzzy find sessions.")
    return
  end

  logDebug("options: ", table.concat(items, " "))

  local opts = {
    prompt_title = "Session Selection",
    finder = finders.new_table({
      results = items,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        if selection then
          callback(items[selection.index])
        end
      end)
      return true
    end,
  }

  pickers.new({}, opts):find()
end

local function loadAutosessionFromFuzzyFind()
  local sessionList = getAutosessions()

  fuzzyFindPrompt(sessionList, function(item)
    loadAutosession(item)
  end)
end
vim.keymap.set("n", "<Leader>os", loadAutosessionFromFuzzyFind, { desc = "[O]pen [S]ession" })

local function writeAutosessionFn(args)
  local name = args and args.fargs[1] or nil
  local bang = args and args.bang or nil

  if name == nil or name == "" or name == vim.NIL then
    name = currSession or defaultSessionName
  end

  if bang then
    writeAutosession(name)
  else
    changeWriteAutoSession(name)
  end
end
vim.api.nvim_create_user_command("WriteAutosession", writeAutosessionFn, {
  nargs = "?",
  bang = true,
  desc = "Save an autosession and mark it as current (! to just write it)",
  force = true,
  complete = getAutosessions,
})

local function loadAutosessionFn(args)
  local name = args and args.fargs[1] or nil

  if name == "" or name == nil or name == vim.NIL then
    name = defaultSessionName
  end

  loadAutosession(name)
end
vim.api.nvim_create_user_command("LoadAutosession", loadAutosessionFn, {
  desc = "Load a session that will be written to upon filewrite",
  nargs = "?",
  force = true,
  complete = getAutosessions,
})
vim.keymap.set("n", "<Leader>O", loadAutosessionFn, { desc = "[O]pen previous session" })

local function whichAutosessionFn()
  vim.notify("Session: " .. currSession, vim.log.levels.INFO)
end
vim.api.nvim_create_user_command("WhichAutosession", whichAutosessionFn, {
  force = true,
  desc = "Output the name of your current session",
})
vim.keymap.set("n", "<Leader>was", whichAutosessionFn, { desc = "[W]hich [A]uto [S]ession" })

local function changeWriteAutoSessionFromInput()
  vim.ui.input({ prompt = "Session name: " }, function(input)
    changeWriteAutoSession(input)
  end)
end
vim.keymap.set("n", "<Leader>ws", changeWriteAutoSessionFromInput, { desc = "[W]rite [S]ession" })

-- in case i wanna add another write condition
local augroup = vim.api.nvim_create_augroup("skc-auto-write-session", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = augroup,
  callback = function()
    changeWriteAutoSession(currSession or defaultSessionName)
  end,
})
