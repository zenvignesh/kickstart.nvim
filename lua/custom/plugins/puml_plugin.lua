local function compile_puml()
  vim.cmd 'write'

  local filename = vim.fn.expand '%'
  local filepath = vim.fn.expand '%:p:h'
  print(filepath)

  os.execute('plantuml -tsvg ' .. filename)

  print 'puml file compiled!'
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.puml',
  callback = compile_puml,
})
