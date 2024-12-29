return {
  'kawre/leetcode.nvim',
  --   build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
  dependencies = {
    'nvim-telescope/telescope.nvim',
    -- "ibhagwan/fzf-lua",
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    -- configuration goes here
    ---@type lc.lang
    lang = 'c',

    vim.api.nvim_set_keymap('n', '<leader>le', ':Leet exit<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<leader>lm', ':Leet menu<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<leader>ll', ':Leet lang<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<leader>lr', ':Leet run<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<leader>ls', ':Leet submit<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<leader>lt', ':Leet tabs<CR>', { noremap = true, silent = true }),
  },
}
