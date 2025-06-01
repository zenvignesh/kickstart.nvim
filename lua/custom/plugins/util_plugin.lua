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

-- Vim buffer related
vim.api.nvim_set_keymap('n', '<C-M-j>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-M-k>', ':bprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':bd<CR>', { noremap = true, silent = true })

-- Open Nvim Terminal
vim.api.nvim_set_keymap('n', '<leader>T', ':term<CR>', { noremap = true, silent = true })

-- Define a keymap to build files in the current working directory
vim.api.nvim_set_keymap('n', '<leader>ma', ':!tmux split-window -v \'make all;echo "Press Enter to close...";read\'<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>me', ':!tmux split-window -v \'make execute;echo "Press Enter to close...";read\'<CR>', { noremap = true, silent = true })

-- Define a keymap to build files in the current working directory
vim.api.nvim_set_keymap('n', '<leader>mc', ':!tmux split-window -v \'make clean;echo "Press Enter to close...";read\'<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>mt', ':!make test<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>md', ':!make debug<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>mD', ':!make doc<CR>', { noremap = true, silent = true })

-- open with
vim.api.nvim_set_keymap('n', '<leader>of', [[:lua OpenInFirefox()<CR>]], { noremap = true, silent = true })

function OpenInFirefox()
  local filename = vim.fn.expand '%:p'
  local ext = vim.fn.expand '%:e'

  if ext == 'puml' then
    filename = filename:gsub('%.puml$', '.svg')
  end

  -- Run Firefox in the background, suppressing terminal output
  vim.fn.jobstart({ 'firefox', filename }, { detach = true })
end

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

vim.api.nvim_create_user_command('SumColumn', function()
  local col = tonumber(vim.fn.input 'Enter column number (1-based): ')
  if not col then
    print 'Invalid column number.'
    return
  end

  local delim = vim.fn.input "Enter delimiter (default '&'): "
  if delim == '' then
    delim = '&'
  end

  -- Get visual selection
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local sum = 0
  for _, line in ipairs(lines) do
    -- First split using user-defined delimiter
    local fields = vim.split(line, delim, { plain = true })
    local raw_field = fields[col]
    if raw_field then
      -- Then split that field by whitespace and pick first number-like part
      local parts = vim.split(raw_field, '%s+', { trimempty = true })
      local num = tonumber(parts[1])
      if num then
        sum = sum + num
      end
    end
  end

  -- Insert result below selection
  local insert_line = end_line
  local sum_text = '-- Sum of column ' .. col .. " (delim: '" .. delim .. "'): " .. sum
  vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, { sum_text })
end, { range = true })

vim.keymap.set('v', '<leader>e', function()
  vim.cmd 'normal! gv'
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_row, start_col = start_pos[2] - 1, start_pos[3] - 1
  local end_row, end_col = end_pos[2] - 1, end_pos[3]

  -- Get the selected text
  local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
  local selected = table.concat(lines):gsub('%s+', '') -- trim whitespace

  local minutes = tonumber(selected)

  if minutes then
    local hours = math.floor((minutes / 60) * 100) / 100
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { tostring(hours) })
    print(minutes .. ' minutes = ' .. hours .. ' hour(s)')
  else
    print 'Not a valid number!'
  end

  -- Restore cursor to start of inserted text
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
end, { desc = 'Convert minutes to hours (decimal)' })
