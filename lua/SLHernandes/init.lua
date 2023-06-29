require("SLHernandes.remap")
require("SLHernandes.set")
vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf"
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf"
  },
  cache_enable = 0,
}
vim.api.nvim_exec([[
  autocmd BufNewFile *.cpp 0r ~/.vim/templates/template.cpp
  ]],
  false
)
