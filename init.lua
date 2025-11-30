require("SLHernandes")
if vim.version.lt(vim.version(), vim.version.parse("v0.12.0-dev")) then
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git", "clone", "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
      lazypath
    })
  end
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup("plugins", {
    dev = { path = "~/Dokumente/srcs/nvim-projects", fallback = true },
    ui = { border = "rounded" }
  })

  vim.cmd("colorscheme tokyonight")
  -- vim.cmd.colorscheme("gruber-darker")

  -- Merlin setup ocaml
  vim.cmd([[
  if executable('opam')
    let g:opamshare=substitute(system('opam var share'),'\n$','','''')
    if isdirectory(g:opamshare."/merlin/vim")
      execute "set rtp+=" . g:opamshare."/merlin/vim"
    endif
  endif
  ]])
else
  require("plugins_v12")
end
