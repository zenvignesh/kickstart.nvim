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

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex',
  callback = compile_latex,
})
