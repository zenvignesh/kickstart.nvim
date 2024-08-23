local function compile_latex()
  vim.cmd 'write'

  local filename = vim.fn.expand '%'
  local filepath = vim.fn.expand '%:p:h'
  print(filepath)

  os.execute('pdflatex -interaction=nonstopmode -output-directory=' .. vim.fn.shellescape(filepath) .. ' ' .. filename .. ' > /dev/null 2>&1')

  -- This compilation need to be done twise, to get the page numbers work correctly
  os.execute('pdflatex -interaction=nonstopmode -output-directory=' .. vim.fn.shellescape(filepath) .. ' ' .. filename .. ' > /dev/null 2>&1')

  local temp_files = { '.aux', '.log', '.nav', '.out', '.snm', '.toc' }

  for _, ext in ipairs(temp_files) do
    -- cool = vim.fn.shellescape(filepath .. '/' .. vim.fn.expand '%:t:r' .. ext)
    -- print(cool)
    os.execute('rm -f ' .. vim.fn.shellescape(filepath .. '/' .. vim.fn.expand '%:t:r' .. ext))
  end

  print 'LaTeX file compiled!'
end

-- Function to check if a file is an entry LaTeX document
local function is_entry_document()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    if string.match(line, '\\documentclass') then
      return true
    end
  end
  return false
end

-- Function to determine the compiler (pdflatex or lualatex)
local function determine_compiler(filepath)
  local lines = vim.fn.readfile(filepath)
  for _, line in ipairs(lines) do
    if string.match(line, '%%! TEX program = lualatex') then
      return 'lualatex'
    end
  end
  return 'pdflatex'
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex',
  callback = function()
    if is_entry_document() then
      -- compile_latex()
    else
    end
  end,
})
