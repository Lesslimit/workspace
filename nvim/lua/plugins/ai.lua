-- AI tooling, all billed to existing CLI subscriptions rather than API keys.
--
-- Two complementary layers:
--   sidekick.nvim  -- switchable terminal for any AI CLI (codex, gemini, opencode, ...)
--   claudecode.nvim -- Claude Code over its IDE protocol, with accept/reject diffs
--
-- Next Edit Suggestions are deliberately left off: that feature is driven by the
-- Copilot LSP and needs a paid GitHub Copilot seat.
return {
  { import = "lazyvim.plugins.extras.ai.sidekick" },

  {
    "folke/sidekick.nvim",
    opts = {
      -- Disabling this also stops the LazyVim extra from enabling the copilot
      -- LSP server, which would otherwise sit there unauthenticated.
      nes = { enabled = false },
    },
  },

  -- Claude Code talks to Neovim over a WebSocket using the same IDE protocol as
  -- the VS Code extension, so edits land as diffs you accept or reject.
  --
  -- Keymaps avoid the <leader>a{a,s,d,t,f,v,p} keys already taken by sidekick.
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.35,
      },
      diff_opts = {
        layout = "vertical",
      },
    },
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    -- stylua: ignore
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude: toggle" },
      { "<leader>aF", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude: focus" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Claude: resume session" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue session" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add current buffer" },
      { "<leader>ae", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: send selection" },
      { "<leader>aM", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
      -- Diff review
      { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
      { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: deny diff" },
      { "<leader>aQ", "<cmd>ClaudeCodeCloseAllDiffs<cr>", desc = "Claude: close all diffs" },
      -- Add a file straight from the explorer
      { "<leader>aA", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Claude: add file", ft = { "neo-tree", "oil" } },
    },
  },
}
