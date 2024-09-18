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
vim.api.nvim_set_keymap('n', '<leader>m', ':!make<CR>', { noremap = true, silent = true })

function InsertTimeStamp()
  -- Get the current timestamp
  local timestamp = os.date '%Y-%m-%d %H:%M:%S'

  -- Insert the timestamp at the cursor position
  vim.api.nvim_put({ timestamp }, 'c', true, true)
end
-- Map <leader>d to insert the current timestamp
vim.api.nvim_set_keymap('n', '<leader>d', ':lua InsertTimeStamp()<CR>', { noremap = true, silent = true })

require 'custom.plugins.latex_plugin'

require 'custom.plugins.markdown_plugin'

require 'custom.plugins.puml_plugin'

require 'custom.plugins.llm_plugin'

require 'custom.plugins.git_plugin'
