-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- ==================================================================
-- This is sample code snippets for references
----------------------------------------------
-- function Todo()
--   print 'Hello world!'
-- end

-- vim.api.nvim_create_user_command('Todo', Todo, {})
-- vim.api.nvim_create_autocmd('CursorHold', { callback = Todo })

-- vim.keymap.set("n", "<leader>b", Todo)
-- ==================================================================

-- Define a keymap to build files in the current working directory
vim.api.nvim_set_keymap('n', '<leader>ma', ':!tmux split-window -v \'make all;echo "Press Enter to close...";read\'<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>me', ':!tmux split-window -v \'make execute;echo "Press Enter to close...";read\'<CR>', { noremap = true, silent = true })

-- Define a keymap to build files in the current working directory
vim.api.nvim_set_keymap('n', '<leader>mc', ':!tmux split-window -v \'make clean;echo "Press Enter to close...";read\'<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>mt', ':!make test<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>md', ':!make debug<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>mD', ':!make doc<CR>', { noremap = true, silent = true })

-- To toggle spell check
vim.api.nvim_set_keymap('n', '<leader>sp', ':set spell!<CR>', { noremap = true, silent = true })

-- Key Mappings to navigate the quickfix list
vim.api.nvim_set_keymap('n', '<C-n>', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':cprev<CR>', { noremap = true, silent = true })

function ToggleQuickfix()
  local is_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      is_open = true
      break
    end
  end
  if is_open then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen'
  end
end

-- Key map to toggle quickfix list
vim.api.nvim_set_keymap('n', '<leader>tq', ':lua ToggleQuickfix()<CR>', { noremap = true, silent = true })

function InsertTimeStamp()
  -- Get the current timestamp
  local timestamp = os.date '%Y-%m-%d %H:%M:%S'

  -- Insert the timestamp at the cursor position
  vim.api.nvim_put({ timestamp }, 'c', true, true)
end
-- Map <leader>d to insert the current timestamp
vim.api.nvim_set_keymap('n', '<leader>d', ':lua InsertTimeStamp()<CR>', { noremap = true, silent = true })

function RenameFile()
  local old_name = vim.fn.expand '%:p'
  local new_name = old_name:gsub(' ', '_')

  if old_name == new_name then
    print 'No spaces in the file name.'
    return
  end

  -- Rename the file
  local success, err = os.rename(old_name, new_name)
  if not success then
    print('Error renaming file: ' .. err)
    return
  end

  -- Reload the buffer
  vim.cmd('edit ' .. new_name)
  print('File renamed to : ' .. new_name)
end
vim.api.nvim_set_keymap('n', '<leader>rf', ':lua RenameFile()<CR>', { noremap = true, silent = true })

-- Function to open PDF with default system application
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWinEnter' }, {
  pattern = '*.pdf',
  callback = function()
    local file = vim.fn.shellescape(vim.fn.expand '%') -- Escape the file name
    vim.cmd('silent !xdg-open ' .. file)
    vim.cmd 'bd!' -- Close buffer after opening the PDF externally
  end,
})

-- Function to open JPG with default system application
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWinEnter' }, {
  pattern = '*.jpg',
  callback = function()
    local file = vim.fn.shellescape(vim.fn.expand '%') -- Escape the file name
    vim.cmd('silent !xdg-open ' .. file)
    vim.cmd 'bd!' -- Close buffer after opening the JPG externally
  end,
})

-- Function to open PDF with default system application
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWinEnter' }, {
  pattern = '*.svg',
  callback = function()
    local file = vim.fn.shellescape(vim.fn.expand '%') -- Escape the file name
    vim.cmd('silent !firefox ' .. file)
    vim.cmd 'bd!' -- Close buffer after opening the PDF externally
  end,
})

require 'custom.plugins.latex_plugin'

require 'custom.plugins.markdown_plugin'

require 'custom.plugins.puml_plugin'

require 'custom.plugins.llm_plugin'

require 'custom.plugins.git_plugin'
