vim.api.nvim_create_augroup('tex_make', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex',
  command = 'silent! make',
  group = 'tex_make',
})
