local SESSION_DIR = "/home/skc/Documents/nvimsessions/"
local defaultSessionName = "latest"
local pointedTo = nil
local currSession = nil

local LabTools = require("labtools")
local logMsg = LabTools.logMsg
local logDebug = LabTools.logDebug
local tableContains = LabTools.tableContains
local fuzzyFindPrompt = LabTools.fuzzyFindPrompt

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
vim.keymap.set("n", "<Leader>ol", loadAutosessionFn, { desc = "[O]pen [L]atest session" })

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
