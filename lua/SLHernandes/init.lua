require("SLHernandes.remap")
require("SLHernandes.set")
require("SLHernandes.packer")
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
 set rtp^="/home/samuelhernandes/.opam/default/share/ocp-indent/vim"
 ]],
 false
)
