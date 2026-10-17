require("config.remote_clipboard").setup()
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true

vim.filetype.add({
  extension = {
    jsonl = "jsonl",
    jsonp = "jsonp",
  },
})

vim.treesitter.language.register("json", "jsonl")
vim.treesitter.language.register("javascript", "jsonp")

-- Python type checker for the lang.python extra. Must live here rather than in
-- the plugin spec: the extra reads this global when the spec is imported, which
-- happens after options load but before plugin specs resolve.
vim.g.lazyvim_python_lsp = "basedpyright"
