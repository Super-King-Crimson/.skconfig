local LabTools = {}

local silent = false
local debugMode = false

function LabTools.logMsg(msg, logLevel)
  if silent then
    return
  end

  vim.notify(msg, logLevel or vim.log.levels.INFO)
end

function LabTools.logDebug(debugMsg, logLevel)
  if debugMode then
    LabTools.logMsg("DEBUG: " .. debugMsg, logLevel)
  end
end

function LabTools.isEmpty(str)
  return str == nil or str == ""
end

function LabTools.matches(str, ...)
  if LabTools.isEmpty(str) then return false end

  local pats = { ... }
  for _, pat in ipairs(pats) do
    if string.find(str, pat) then return false end
  end

  return true
end

function LabTools.trim(s)
  return string.match(s, "^%s*(.-)%s*$")
end

function LabTools.tableContains(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

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

function LabTools.fuzzyFindPrompt(items, callback)
  if #items == 0 then
    LabTools.logMsg("There is nothing to find", vim.log.levels.ERROR)
    return false
  end

  if not pickers then
    error("You must have telescope installed to fuzzy find.")
    return false
  end

  LabTools.logDebug("options: " .. table.concat(items, " | "), vim.log.levels.INFO)

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
  return true
end

return LabTools
