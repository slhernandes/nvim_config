vim.api.nvim_exec2([[
  autocmd BufNewFile [0-9]*.cpp 0r ~/.config/nvim/templates/template.cpp
  ]], { output = false })
vim.api.nvim_exec2([[
  autocmd BufNewFile aoc*.rs 0r ~/.config/nvim/templates/template.rs
  ]], { output = false })
vim.api.nvim_exec2([[
  autocmd BufNewFile *.cc 0r ~/.config/nvim/templates/opp_template.cc
  ]], { output = false })
vim.api.nvim_exec2([[
  autocmd BufNewFile *.ned 0r ~/.config/nvim/templates/opp_template.ned
  ]], { output = false })
vim.api.nvim_exec2([[
  autocmd BufNewFile *.ini 0r ~/.config/nvim/templates/opp_template.ini
  ]], { output = false })
vim.api.nvim_exec2([[
  autocmd BufNewFile *.typ 0r ~/.config/nvim/templates/template.typ
  ]], { output = false })
