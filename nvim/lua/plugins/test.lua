-- Neotest. The rust extra already registers the `rustaceanvim.neotest` adapter
-- as optional, so importing this is all that's needed to activate it.
return {
  { import = "lazyvim.plugins.extras.test.core" },
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      local adapter = vim.tbl_extend("force", {}, require("rustaceanvim.neotest"))
      local root = adapter.root
      adapter.root = function(path)
        -- Neotest can resume discovery in a libuv callback. Rust root detection
        -- uses Neovim APIs that require the main event loop.
        require("nio").scheduler()
        return root(path)
      end
      opts.adapters["rustaceanvim.neotest"] = false
      table.insert(opts.adapters, adapter)
    end,
  },
}
