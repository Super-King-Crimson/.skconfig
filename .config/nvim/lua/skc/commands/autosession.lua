local SESSION_DIR = "/home/skc/Documents/nvimsessions/"
local defaultSessionName = "latest"
local pointedTo = nil
local currSession = nil
local silent = false
local debugMode = false

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

local function getFullPathFromSessionName(name)
  return SESSION_DIR .. name .. ".vim"
end

local function getSessionNameFromFullPath(path)
  local relPath = vim.fn.slice(path, vim.fn.strcharlen(SESSION_DIR))
  return vim.fn.fnamemodify(relPath, ":r")
end

local function getSymLinkTarget(link)
  local out = vim.fn.execute("!readlink " .. link)

  -- I'm not taking questions on how this works
  -- TODO: make this shit less shitty
  local linkedFile = vim.fn.split(out, "\n")[3]

  -- Output: "\n:!readlink /home/skc/Documents/testnvimsessions/latest.vim\r\n\n/home/skc/Documents/testnvimsessions/nvimconfig.vim\n"
  -- Extracted path to link: not found :(
  if linkedFile and vim.uv.fs_stat(linkedFile) then
    return getSessionNameFromFullPath(linkedFile)
  end
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

  local sessionPath = getFullPathFromSessionName(name)

  local parentDir = vim.fn.fnamemodify(sessionPath, ":h")
  local dirExists = vim.fn.isdirectory(parentDir) == 1

  if not dirExists then
    logDebug(parentDir .. " doesn't exist, initializing")
    vim.cmd("silent !mkdir -p " .. parentDir)
  end

  vim.cmd("silent mksession! " .. sessionPath)

  logDebug("Wrote session" .. sessionPath, vim.log.levels.INFO)

  return sessionPath
end

local function changeWriteAutoSession(name)
  if name == nil or name == "" or name == vim.NIL then
    error("provide a valid session name")
  end

  if name == defaultSessionName and currSession == nil then
    -- unhook from any symlink and treat as a temporary standalone session
    vim.cmd("silent! !rm " .. getFullPathFromSessionName(defaultSessionName))
  end

  currSession = name

  writeAutosession(currSession)
end

local function getAutosessions()
  local sessions = vim.fn.glob(SESSION_DIR .. "**/*.vim", true, true)
  local sessionNames = {}

  for i, sessionPath in ipairs(sessions) do
    sessionNames[i] = getSessionNameFromFullPath(sessionPath)
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

  vim.cmd("silent! %bwipeout!")
  vim.cmd("silent! source " .. getFullPathFromSessionName(sessionName))

  currSession = sessionName

  logMsg("Successfully sourced " .. sessionName, vim.log.levels.INFO)
end

-- for a function a bit down don't worry abt it
local pickers
local finders
local conf
local actions

local action_state
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
    logMsg("There are no autosessions", vim.log.levels.ERROR)
    return
  end

  if not pickers then
    error("You must have telescope installed to fuzzy find sessions.")
    return
  end

  logDebug("options: " .. table.concat(items, " | "), vim.log.levels.INFO)

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
  -- is default session a symlink to a different session
  if currSession == defaultSessionName then
    local fullPath = getFullPathFromSessionName(defaultSessionName)
    local potentialTarget = getSymLinkTarget(fullPath)

    if potentialTarget then
      print("Session: " .. defaultSessionName .. " > " .. potentialTarget)
      return
    end
  end

  print("Session: " .. (currSession or "none"))
end
vim.api.nvim_create_user_command("WhichAutosession", whichAutosessionFn, {
  force = true,
  desc = "Output the name of your current session",
})
vim.keymap.set("n", "<Leader>?s", whichAutosessionFn, { desc = "Which [S]ession?" })

local function changeWriteAutoSessionFromInput()
  vim.ui.input({ prompt = "Session name: " }, function(input)
    changeWriteAutoSession(input)
  end)
end

vim.keymap.set("n", "<Leader>ws", changeWriteAutoSessionFromInput, { desc = "[W]rite [S]ession" })

local function editAutosessions()
  vim.cmd("edit " .. SESSION_DIR)
end
vim.api.nvim_create_user_command("EditAutosessions", editAutosessions, {
  desc = "Go to directory of autosessions for easy deletion, renaming, etc.",
})
vim.keymap.set("n", "<Leader>na", "<cmd>EditAutosessions<CR>", { desc = "[N]eovim [A]utosessions" })

local augroup = vim.api.nvim_create_augroup("skc-auto-write-session", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = augroup,
  callback = function()
    changeWriteAutoSession(currSession or defaultSessionName)
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = augroup,
  callback = function()
    if currSession and currSession ~= defaultSessionName then
      vim.cmd("silent! !rm " .. getFullPathFromSessionName(defaultSessionName))

      vim.cmd(
        "silent! !ln -sf "
          .. getFullPathFromSessionName(currSession)
          .. " "
          .. getFullPathFromSessionName(defaultSessionName)
      )
    end
  end,
})
