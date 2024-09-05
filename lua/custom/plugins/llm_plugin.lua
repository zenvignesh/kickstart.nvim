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

local function get_llm_result(text)
  -- Use external command to send the text to 'ollama'
  local command = 'echo "' .. text .. '" | ollama run dolphin-llama3'

  -- Run the command and capture the output
  local handle = io.popen(command)
  local result = handle:read '*a'
  handle:close()

  -- Remove the last two characters from the result
  result = result:sub(1, -3)

  return result
end

local function get_visual_selection_range()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_line = start_pos[2] -- Start line number
  local end_line = end_pos[2] -- End line number
  return start_line, end_line
end

local function set_the_result_in_vim_buffer(result)
  local start_line, end_line = get_visual_selection_range()

  -- Insert the result after the visual selection
  vim.api.nvim_buf_set_lines(0, end_line, end_line, false, { result })
end

function Run_ollama()
  local text = get_visual_selection()
  local result = get_llm_result(text)
  set_the_result_in_vim_buffer(result)
end

vim.api.nvim_set_keymap('v', '<leader>o', ':lua Run_ollama()<CR>', { noremap = true, silent = true })
