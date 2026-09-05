function Create_project_from_selection()
  -- Get the visually selected text
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local selected_text = table.concat(lines, ' '):sub(start_pos[3], end_pos[3])

  -- Sanitize the selected text to create a valid folder and filename
  local project_name = selected_text:gsub('%s+', '_'):gsub('[^a-zA-Z0-9_]', '')

  -- Boilerplate content for the .tex file
  local tex_boilerplate = [[
\documentclass[12pt]{article}
\usepackage{pdfpages}
\usepackage[pdfborder={0 0 0}, colorlinks=true, linkcolor=blue, urlcolor=blue, bookmarksopen=true]{hyperref}
\usepackage[utf8]{inputenc}
\title{TITLE_PLACEHOLDER}
\author{author name}
\date{\today}

\begin{document}

\maketitle
\tableofcontents
\clearpage

\section{Introduction}
Write your introduction here.
%\includepdf[pages=-]{~/pdffiles.pdf}

\end{document}
]]

  -- Boilerplate content for the Makefile
  local makefile_boilerplate = [[
all:
	pdflatex TITLE_PLACEHOLDER.tex
	pdflatex TITLE_PLACEHOLDER.tex
	zathura TITLE_PLACEHOLDER.pdf

clean:
	rm -f TITLE_PLACEHOLDER.aux TITLE_PLACEHOLDER.log TITLE_PLACEHOLDER.pdf
]]

  -- Replace placeholders in boilerplate text
  tex_boilerplate = tex_boilerplate:gsub('TITLE_PLACEHOLDER', selected_text)
  makefile_boilerplate = makefile_boilerplate:gsub('TITLE_PLACEHOLDER', project_name)

  -- Create folder
  local folder_path = string.format('%s', project_name)
  os.execute(string.format('mkdir -p "%s"', folder_path))

  -- Write the boilerplate content to the .tex file
  local tex_file = io.open(string.format('%s/%s.tex', folder_path, project_name), 'w')
  if tex_file then
    tex_file:write(tex_boilerplate)
    tex_file:close()
  else
    print 'Error: Could not create .tex file.'
    return
  end

  -- Write the boilerplate content to the Makefile
  local makefile = io.open(string.format('%s/Makefile', folder_path), 'w')
  if makefile then
    makefile:write(makefile_boilerplate)
    makefile:close()
  else
    print 'Error: Could not create Makefile.'
    return
  end

  -- Create a new tmux window
  local tmux_cmd = string.format("tmux new-window -n '%s' -c '%s'", project_name, folder_path)
  os.execute(tmux_cmd)

  print('Project created with boilerplate: ' .. project_name)
end

-- Keybinding to trigger the function
vim.api.nvim_set_keymap('v', '<leader>p', ':lua Create_project_from_selection()<CR>', { noremap = true, silent = true })
