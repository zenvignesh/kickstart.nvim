-- Open new tmux window for 'work' folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>ww",
	':!tmux new-window -n "WORK" -c ~/Documents/work/ \\; send-keys "nvim" C-m<CR>',
	{ noremap = true, silent = true, desc = "Open new tmux window for WORK folder" }
)

-- Open new tmux window for 'Calls' folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>wc",
	':!tmux new-window -n "CALLS" -c ~/Documents/Acer-Aspire-5/2-Area/personal/calls/ \\; send-keys "nvim" C-m<CR>',
	{ noremap = true, silent = true, desc = "Open new tmux window for CALLS folder" }
)

-- Open new tmux window for 'ltts' folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>wl",
	':!tmux new-window -n "LTTS" -c ~/Documents/Acer-Aspire-5/2-Area/work/ltts/ \\; send-keys "nvim" C-m<CR>',
	{ noremap = true, silent = true, desc = "Open new tmux window for LTTS folder" }
)

-- Open new tmux window for 'finances' folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>wf",
	':!tmux new-window -n "FINANCES" -c ~/Documents/Acer-Aspire-5/2-Area/personal/finance-tasks/ \\; send-keys "nvim" C-m<CR>',
	{ noremap = true, silent = true, desc = "Open new tmux window for FINANCES folder" }
)

-- Open new tmux window for 'dot files' folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>wd",
	':!tmux new-window -n "DOT FILES" -c ~/dotfiles/ \\; send-keys "nvim" C-m<CR>',
	{ noremap = true, silent = true, desc = "Open new tmux window for DOT FILES folder" }
)

-- Open new tmux window for 'gemini' folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>wg",
	':!tmux new-window -n "GEMINI" -c ~/Documents/Acer-Aspire-5/0-Inbox/workspace/ \\; send-keys "nvim" C-m<CR>',
	{ noremap = true, silent = true, desc = "Open new tmux window for GEMINI folder" }
)
