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
