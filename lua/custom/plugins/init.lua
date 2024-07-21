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
-- Function to get the word under the cursor and call the lua function

local function get_visual_selection()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  local lines = vim.fn.getline(start_line, end_line)
  -- print(#lines)

  if #lines == 0 then
    return ''
  end

  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  lines[1] = string.sub(lines[1], start_col)

  return table.concat(lines, '\n')
end

local function process_selection()
  local selected_text = get_visual_selection()
  local modified_text = selected_text:gsub(' ', '-')
  local filename = Generate_unique_filename(modified_text)
  local markdown_link_text = '[' .. selected_text .. ']' .. '(./' .. filename .. ')'

  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  local line = vim.fn.getline(start_line)

  local before_text = string.sub(line, 1, start_col - 1)
  local after_text = string.sub(line, end_col + 1)
  local new_line = before_text .. markdown_link_text .. after_text

  vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false, { new_line })

  vim.cmd 'write' -- save the file
  vim.cmd('edit ' .. filename)
end

vim.api.nvim_create_user_command('MarkDownLink', function()
  process_selection()
end, { nargs = 0, range = true })

vim.api.nvim_set_keymap('v', '<C-l>', '<Esc>:MarkDownLink<CR>', { noremap = true, silent = true })
