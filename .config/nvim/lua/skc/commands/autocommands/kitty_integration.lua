local augroup = vim.api.nvim_create_augroup("SKC_KittyConnectionAugroup", { clear = true })
local socket = "unix:/tmp/kittynvim.socket"
local remoteDir = vim.fs.joinpath(vim.env.HOME, "Remote")

vim.api.nvim_create_autocmd("DirChanged", {
  group = augroup,
  desc = "Send current working directory to kitty",
  callback = function()
    local parent = os.getenv("KITTY_PARENT")
    if parent == "yes" then
      local targetDir = vim.fn.getcwd()
      if string.find(targetDir, remoteDir, 1, true) then
        -- idk some lua string indexing thing
        local relPath = string.sub(targetDir, string.len(remoteDir) + 1)
        -- make sure $HOME is expanded on the remote, not locally where we send it
        targetDir = vim.fs.joinpath("\\$HOME", relPath)
      end

      local command = "kitten @ --to " ..  socket .. " send-text --match env:KITTY_CHILD \x15\x01\x0b cd " .. targetDir .. " \r"
      vim.fn.system(command)
    end
  end
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = augroup,
  desc = "Close entire kitty instance on vim farewell",
  callback = function()
    local parent = os.getenv("KITTY_PARENT")

    if parent == "yes" and _G.FAREWELL == "yes" then
      -- escape codes to cancel any running processes then clear the line
      local command = "kitten @ --to " ..  socket .. " close-tab --match 'env:KITTY_CHILD or env:KITTY_PARENT'"
      vim.fn.system(command)
    end
  end
})
