return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    {
      "ownself/nvim-dap-unity",
      build = function()
        -- make sure adapter to be installed properly
        require("nvim-dap-unity").install()
      end,
      opts = {
        auto_install_on_start = true,
        add_default_cs_configuration = true,
        enable_unity_cs_configuration = true,
      },
    },
  },

  keys = {
    {
      "<Leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "DAP Continue",
      mode = "n",
    },
    {
      "<Leader>o?",
      function()
        require("dapui").toggle()
      end,
      desc = "[O]pen Why Is My Shit Broken[?] (DAP UI Toggle)",
      mode = "n",
    },
    {
      "<Leader>dd",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP Toggle Breakpoint",
      mode = "n",
    },
    {
      "<Leader>dl",
      function()
        require("dap").step_over()
      end,
      desc = "DAP Step Over",
      mode = "n",
    },
    {
      "<Leader>dj",
      function()
        require("dap").step_into()
      end,
      desc = "DAP Step Into",
      mode = "n",
    },
    {
      "<Leader>dk",
      function()
        require("dap").step_out()
      end,
      desc = "DAP Step Out",
      mode = "n",
    },
  },
  -- Lazy loading cmd
  cmd = {
    "Dap",
    "DapContinue",
    "DapStepOver",
    "DapStepInto",
    "DapStepOut",
    "DapToggleBreakpoint",
    "DapUI",
    "DapLaunch",
    "DapAttach",
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    require("nvim-dap-unity").setup()

    -- Dap UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.after.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.after.event_exited["dapui_config"] = function()
      dapui.close()
    end

    dap.configurations.cs = dap.configurations.cs or {}

    vim.keymap.set("n", "<Leader>dh", function()
      dap.step_out()
    end, { desc = "Debug Step Out" })

    vim.keymap.set("n", "<Leader>do", function()
      dapui.toggle()
    end, { desc = "[D]ebug [O]pen UI" })
  end,
}
