require("SLHernandes.remap")
require("SLHernandes.set")
vim.api.nvim_exec([[
  autocmd BufNewFile *.cpp 0r ~/.vim/templates/template.cpp
  ]],
  false
)
