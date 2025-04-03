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
  callback = function ()
    vim.opt_local.inde = ""
  end
})
-- change the configuration when editing a python file
--vim.api.nvim_create_autocmd("BufEnter", {
--  pattern = "*.py",
--  callback = function(e)
--    if string.match(e.file, ".otter.") then return end
--    if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
--      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
--    else
--      vim.g.molten_virt_lines_off_by_1 = false
--    end
--  end
--})

-- Undo those config changes when we go back to a markdown or quarto file
--vim.api.nvim_create_autocmd("BufEnter", {
--  pattern = {"*.qmd", "*.md", "*.ipynb"},
--  callback = function(e)
--    if string.match(e.file, ".otter.") then return end
--    if require("molten.status").initialized() == "Molten" then
--      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
--    else
--      vim.g.molten_virt_lines_off_by_1 = true
--    end
--  end
--})
