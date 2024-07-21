local function normal_mode(keymap, action)
  vim.keymap.set('n', keymap, action)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>z', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>x', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Copy file path to clipboard using xclip
vim.api.nvim_set_keymap('n', '<leader>cp', ':let @+=expand("%:p")<CR>', { desc = '[C]opy file [P]ath', noremap = true, silent = true })

-- Remap Ctrl+Z to do nothing
vim.api.nvim_set_keymap('n', '<C-z>', '<NOP>', { noremap = true, silent = true })

-- Copy current buffer to a new file with a new name
vim.api.nvim_set_keymap(
  'n',
  '<leader>cw',
  ':lua vim.cmd("write " .. vim.fn.input("Save current buffer as: "))<CR>',
  { desc = '[C]opy current buffer to a new [W]rite file', noremap = true, silent = true }
)

normal_mode('<leader>ts', function()
  vim.cmd('belowright 12split')
  vim.cmd('set winfixheight')
  vim.cmd('term')
  vim.cmd('startinsert')
end)

normal_mode('<leader>tu', function()
  vim.cmd('terminal')
  vim.cmd('startinsert')
end)
