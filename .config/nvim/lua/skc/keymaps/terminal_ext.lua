local function changeCwdToCurrentTerminal()
  if vim.bo.buftype ~= "terminal" then
    vim.notify("Not in a terminal buffer", vim.log.levels.WARN)
    return
  end

  local terminal_pid = vim.fn.jobpid(vim.b.terminal_job_id)
  assert(terminal_pid ~= nil)

  if terminal_pid then
    -- Gets cwd of that process id
    local handle = io.popen("pwdx " .. terminal_pid .. " 2>/dev/null")
    local result
    local target_dir

    if handle then
      result = handle:read("*a") or ""
      handle:close()

      -- Parse the path (format is usually "PID: /path/to/dir")
      target_dir = vim.trim(result:match("%d+: (.+)%s*$"))
    end

    if target_dir then
      vim.cmd("tabnew")
      vim.cmd("tcd " .. target_dir)

      vim.notify("cwd: " .. target_dir, vim.log.levels.INFO)
    else
      vim.notify("Failed to update cwd (does pwdx command exist?)", vim.log.levels.ERROR)
    end
  end
end

-- Create a user command for easy ccess
-- Esc + Esc to exit terminal (VERY IMPORTANT!)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-S-V>", "<C-\\><C-n>pA", { desc = "Paste" })
vim.keymap.set("t", "<A-o>", changeCwdToCurrentTerminal)
