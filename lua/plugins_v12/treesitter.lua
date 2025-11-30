vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})

require'nvim-treesitter.install'.compilers = {"gcc-12", "clang", "gcc"}
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "c", "lua", "vim", "vimdoc", "query", "latex"},
  sync_install = false,
  auto_install = true,
  ignore_install = {"javascript"},
  highlight = {enable = true, additional_vim_regex_highlighting = false}
}
