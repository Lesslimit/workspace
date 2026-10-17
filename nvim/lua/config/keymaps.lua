-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function format_jsonl_pretty()
  if vim.bo.filetype ~= "jsonl" then
    vim.notify("JSONL pretty formatting is only available for jsonl buffers", vim.log.levels.WARN)
    return
  end

  local input = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  if input ~= "" then
    input = input .. "\n"
  end

  local result = vim.system({ "jq", "." }, { text = true, stdin = input }):wait()
  if result.code ~= 0 then
    vim.notify(vim.trim(result.stderr), vim.log.levels.ERROR)
    return
  end

  local output = vim.split(result.stdout:gsub("\n$", ""), "\n", { plain = true })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result.stdout == "" and {} or output)
  vim.b.autoformat = false
end

vim.api.nvim_create_user_command("JsonlFormatPretty", format_jsonl_pretty, {
  desc = "Pretty format JSONL stream",
})

vim.keymap.set("n", "<leader>cj", format_jsonl_pretty, {
  desc = "Pretty Format JSONL",
})

-- Toggle display of warning/info/hint diagnostics. Errors are always drawn.
-- The default (warnings hidden) is set in lua/plugins/lsp.lua.
local show_warnings = false

local function warning_visibility(show)
  -- vim.diagnostic.config() deep-merges, so clearing `severity` by setting it to
  -- nil leaves the previous filter in place. Always pass an explicit filter:
  -- HINT is the least severe level, so min=HINT draws everything.
  local filter = { min = show and vim.diagnostic.severity.HINT or vim.diagnostic.severity.ERROR }
  local current = vim.diagnostic.config() or {}

  -- Handlers may be `true`, `false` or a table; normalise to a table so the
  -- severity filter can be attached without losing icons/spacing/prefix.
  local function filtered(value)
    if value == false or value == nil then
      return value
    end
    local handler = type(value) == "table" and vim.deepcopy(value) or {}
    handler.severity = filter
    return handler
  end

  vim.diagnostic.config({
    virtual_text = filtered(current.virtual_text),
    signs = filtered(current.signs),
    underline = filtered(current.underline),
  })
end

Snacks.toggle({
  name = "Diagnostic Warnings",
  get = function()
    return show_warnings
  end,
  set = function(state)
    show_warnings = state
    warning_visibility(state)
  end,
}):map("<leader>ux")
