local SESSION_DIR = "/home/skc/Documents/nvimsessions/"
local defaultName = "latest.vim"
local oopsie = "latest"
local currSession = nil

local augroup = vim.api.nvim_create_augroup("skc-auto-write-session", { clear = true })

local function writeAutosession(name)
  if name == nil or name == "" then
    name = currSession or oopsie
  end

  currSession = name
  local sessionPath = SESSION_DIR .. name .. ".vim"

  vim.cmd("mksession! " .. sessionPath)
  return sessionPath
end

local function getAutosessions()
  local sessions = vim.fn.glob(SESSION_DIR .. "**/*.vim", true, true)
  local choiceArray = {}

  for i, sessionPath in ipairs(sessions) do
    local relPath = vim.fn.slice(sessionPath, vim.fn.strcharlen(SESSION_DIR))
    local noExt = vim.fn.fnamemodify(relPath, ":r")

    choiceArray[i] = noExt
  end

  return { files = sessions, shortened = choiceArray }
end

local function getValidSessionPathInputs()
  local shortenedNames = getAutosessions().shortened
  local validInputs = {}

  for _, name in ipairs(shortenedNames) do
    table.insert(validInputs, name)

    if vim.fn.match(name, "/") ~= -1 then
      table.insert(validInputs, vim.fn.fnamemodify(name, ":t"))
    end
  end

  return validInputs
end

local function resolveAutosessionPath(name)
  local files = getAutosessions().files
  local short = getAutosessions().shortened

  local winner
  local winnerIndex
  local winnerLength = 0

  -- return the shortest match so there's some consistency
  -- also so you can actually pick the shorter ones easier
  for i, shortPath in ipairs(short) do
    if vim.fn.match(shortPath, name) ~= -1 then
      if winner == nil or vim.fn.strcharlen(shortPath) < winnerLength then
        winner = files[i]
        winnerIndex = i
        winnerLength = vim.fn.strcharlen(shortPath)
      end
    end
  end

  return files[winnerIndex]
end

vim.api.nvim_create_user_command("LoadAutosession", function(args)
  if getValidSessionPathInputs()[1] == nil then
    vim.notify("There are currently no sessions. Please make one by saving a file.", vim.log.levels.WARN)
  end

  local sessionName = args.fargs[1]

  if sessionName == nil or sessionName == "" then
    sessionName = oopsie
  end

  local bouttaGetSourced = resolveAutosessionPath(sessionName)
  if bouttaGetSourced == nil then
    vim.notify("Could not find session " .. sessionName, vim.log.levels.ERROR)
  end

  vim.cmd("silent! source " .. bouttaGetSourced)
  vim.notify("Successfully sourced " .. bouttaGetSourced, vim.log.levels.INFO)
end, {
  nargs = "?",
  desc = "Open",
  force = true,
  complete = function()
    return getValidSessionPathInputs()
  end,
})

-- Couldn't figure out how to get input working so here we go ig
vim.keymap.set("n", "<Leader>os", ":LoadAutosession ", { desc = "[O]pen [S]ession" })

vim.api.nvim_create_user_command("WriteAutosession", function(args)
  writeAutosession(args.fargs[1])
end, { nargs = "?", desc = "Create a session that will be automatically saved", force = true })

vim.keymap.set("n", "<Leader>ws", function()
  vim.ui.input({ prompt = "Session name: " }, function(input)
    local path = writeAutosession(input)
    vim.notify("Session saved at " .. path, vim.log.levels.INFO)
  end)
end, { desc = "[W]rite [S]ession" })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = augroup,
  command = "WriteAutosession",
})

vim.keymap.set("n", "<Leader>O", "<cmd>LoadAutosession<CR>", { desc = "[O]pen previous session" })
