return {
  { import = "lazyvim.plugins.extras.dap.core" },
  {
    "mfussenegger/nvim-dap",
    -- Keep LazyVim's <leader>d mappings and add familiar debugger keys.
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Run / Continue",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Stop",
      },
    },
    opts = function()
      local dap = require("dap")
      -- Also support the adapter name used by VS Code launch.json files.
      dap.adapters.coreclr = dap.adapters.netcoredbg
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        local configs = dap.configurations[lang] or {}
        table.insert(
          configs,
          1,
          setmetatable({
            name = ".NET: Build and debug project",
            type = "netcoredbg",
            request = "launch",
            stopAtEntry = true,
            justMyCode = true,
            console = "integratedTerminal",
          }, {
            __call = function(config)
              return require("config.dotnet-debug").build(config)
            end,
          })
        )
        table.insert(configs, {
          name = ".NET: Attach to process",
          type = "netcoredbg",
          request = "attach",
          processId = require("dap.utils").pick_process,
          justMyCode = true,
        })
        dap.configurations[lang] = configs
      end
    end,
  },
}
