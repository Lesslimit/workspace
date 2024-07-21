return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require('nvim-treesitter.configs')

      -- configure treesitter
      treesitter.setup({
        modules = {},

        -- enable syntax highlighting
        highlight = {
          enable = true,
        },

        -- enable indentation
        indent = { enable = true },

        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = {},

        -- ensure these language parsers are installed
        ensure_installed = {
          'json',
          'javascript',
          'typescript',
          'tsx',
          'yaml',
          'html',
          'css',
          'markdown',
          'markdown_inline',
          'bash',
          'lua',
          'vim',
          'dockerfile',
          'gitignore',
          'vimdoc',
          'c',
          'c_sharp',
          'zig',
          'bicep',
          'csv',
          'go',
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },

              ['a='] = { query = '@assignment.outer', desc = 'Select outer part of the [A]ssignment' },
              ['i='] = { query = '@assignment.inner', desc = 'Select inner part of the [A]ssignment' },
              ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of the [A]ssignment' },
              ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of the [A]ssignment' },

              ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/[A]rgument' },
              ['ia'] = { queyr = '@parameter.inner', desc = 'Select inner part of a parameter/[A]rgument' },

              ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of the [C]onditional' },
              ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of the [C]onditional' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
}
