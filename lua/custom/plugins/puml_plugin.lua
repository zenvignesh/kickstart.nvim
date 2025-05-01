function Compile_puml()
  local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local _, _ = pcall(function()
    os.execute('plantuml -tsvg ' .. bufname)
  end)
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.puml',
  callback = Compile_puml,
})
