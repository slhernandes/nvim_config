-- Highlight briefly yanked texts
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api
      .nvim_create_augroup('kickstart-highlight-yank', {clear = true}),
  callback = function() vim.highlight.on_yank() end
})
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Disable indenting on python file",
  pattern = "*.py",
  group = vim.api.nvim_create_augroup("py_indent", {clear = true}),
  callback = function() vim.opt_local.inde = "" end
})
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Check error on save",
  pattern = "*.ml",
  group = vim.api.nvim_create_augroup("merlin", {clear = true}),
  command = "MerlinErrorCheck"
})
