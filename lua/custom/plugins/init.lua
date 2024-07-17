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

-- Consider moving this function into separate file

function Generate_unique_filename(description)
  local timestamp = os.date '%Y%m%d_%H%M%S'
  -- print(timestamp)
  local handle = io.popen 'uuidgen'
  local uuid = handle:read('*a'):gsub('%s+', '')
  handle:close()
  local unique_id = uuid:sub(1, 8)
  -- print(unique_id)
  -- print('%s_%s', timestamp, unique_id)
  Res = string.format('%s_%s_%s.md', description, timestamp, unique_id)
  -- print(Res)
  return Res
  -- return string.format('%s_%s_%s.txt', timestamp, unique_id)
  -- return string.format('%s_%s_%s.txt', timestamp)
  -- string.format('%s_%s_%', timestamp)
  -- return string.format '%s_%s_%s.txt'
  -- print 'hello world'
  -- print(string.format('%s_%s_%s.md', timestamp, unique_id))
end

function Save_as_unique(description)
  local filename = Generate_unique_filename(description)
  print(filename)
  vim.cmd('saveas' .. ' ' .. filename)
  print('Saved as ' .. filename)
end

vim.api.nvim_create_user_command('W', function(opts)
  local description = opts.args
  Save_as_unique(description)
end, { nargs = 1 })
-- ==================================================================
-- return {}
