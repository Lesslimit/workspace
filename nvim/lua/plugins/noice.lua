-- basedpyright re-analyses on every buffer change and reports $/progress each
-- time, so noice's mini view flashes "✔ basedpyright" in the corner on every
-- edit. Skip its progress messages only; gopls, rust-analyzer and omnisharp do
-- slow indexing work where the indicator still earns its place.
return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            return vim.tbl_get(message.opts or {}, "progress", "client") == "basedpyright"
          end,
        },
        opts = { skip = true },
      })
    end,
  },
}
