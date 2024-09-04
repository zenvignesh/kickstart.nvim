function OpenInGithub()
  local handle = io.popen 'git remote get-url origin'
  local url = handle:read('*a'):gsub('\n', '')
  handle:close()

  local handle = io.popen 'git branch --show-current'
  local branch = handle:read('*a'):gsub('\n', '')
  handle:close()

  local filepath = vim.fn.expand '%:~:.'
  local line = vim.fn.line '.'

  url = url:gsub('%.git$', '')
  local github_url = url .. '/blob/' .. branch .. '/' .. filepath .. '/' .. '#L' .. line

  os.execute('firefox ' .. github_url)
end

vim.api.nvim_set_keymap('n', '<leader>gs', ':lua OpenInGithub()<CR>', { noremap = true, silent = true })
