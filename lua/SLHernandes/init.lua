require("SLHernandes.remap")
require("SLHernandes.set")
vim.api.nvim_exec([[
  autocmd BufNewFile 1*.cpp 0r ~/.config/nvim/templates/template.cpp
  ]],
  false
)
vim.api.nvim_exec([[
  autocmd BufNewFile aoc*.rs 0r ~/.config/nvim/templates/template.rs
  ]],
  false
)
vim.api.nvim_exec([[
  autocmd BufNewFile *.cc 0r ~/.config/nvim/templates/opp_template.cc
  ]],
  false
)
vim.api.nvim_exec([[
  autocmd BufNewFile *.ned 0r ~/.config/nvim/templates/opp_template.ned
  ]],
  false
)
vim.api.nvim_exec([[
  autocmd BufNewFile *.ini 0r ~/.config/nvim/templates/opp_template.ini
  ]],
  false
)
vim.api.nvim_exec([[
 set rtp^="/home/samuelhernandes/.opam/default/share/ocp-indent/vim"
 ]],
 false
)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
