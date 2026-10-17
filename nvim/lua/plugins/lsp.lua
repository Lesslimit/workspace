-- Diagnostics default to errors only. Warnings, hints and info are still
-- produced by the server and reachable via :Trouble or vim.diagnostic, they are
-- just not drawn in the buffer. Toggle them back with <leader>ux.
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
        signs = { severity = { min = vim.diagnostic.severity.ERROR } },
        underline = { severity = { min = vim.diagnostic.severity.ERROR } },
      })
    end,
  },
}
