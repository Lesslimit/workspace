return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "/home/oparub/.dotnet/tools/csharpier",
          args = { "format", "--write-stdout" },
          stdin = true,
        },
      },
    },
  },
}
