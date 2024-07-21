-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[H]unk [S]tage' }) -- Stage the current hunk
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[H]unk [R]eset' }) -- Reset the current hunk
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = '[H]unk [S]tage (visual)' }) -- Stage the selected hunk in visual mode
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = '[H]unk [R]eset (visual)' }) -- Reset the selected hunk in visual mode
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[H]unk [S]tage [B]uffer' }) -- Stage the entire buffer
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[H]unk [U]ndo [S]tage' }) -- Undo the last hunk stage
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[H]unk [R]eset [B]uffer' }) -- Reset the entire buffer
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[H]unk [P]review' }) -- Preview the current hunk
      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { desc = '[H]unk [B]lame (full)' }) -- Show blame for the current line (full details)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle [B]lame' }) -- Toggle blame for the current line
      map('n', '<leader>hd', gitsigns.diffthis, { desc = '[H]unk [D]iff' }) -- Show the diff for the current file
      map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
      end, { desc = '[H]unk [D]iff (against HEAD)' }) -- Show the diff against HEAD
      map('n', '<leader>td', gitsigns.toggle_deleted, { desc = '[T]oggle [D]eleted' }) -- Toggle showing deleted lines

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = '[I]nside [H]unk' }) -- Select the inside of the current hunk
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',

      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },
}
