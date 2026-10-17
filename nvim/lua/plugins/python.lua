-- basedpyright (types) + ruff (lint/format) are selected by the extra; the
-- checker is chosen via vim.g.lazyvim_python_lsp in config/options.lua.
-- dap.core and test.core are already imported, so nvim-dap-python and
-- neotest-python activate automatically.
return {
  { import = "lazyvim.plugins.extras.lang.python" },
}
