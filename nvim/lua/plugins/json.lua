return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "jq" },
        jsonl = { "jq_jsonl" },
        jsonp = { "format_jsonp" },
      },
      formatters = {
        jq_jsonl = {
          command = "jq",
          args = { "-c", "." },
        },
        format_jsonp = {
          command = vim.fn.expand("~/.local/bin/format-jsonp"),
        },
      },
    },
  },
}
