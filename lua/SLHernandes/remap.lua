-- set mapleader as space
vim.g.mapleader = " "
-- space p v as netrw hotkey
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- copy/paste to/from clipboard
vim.keymap.set("n", "<leader>yy", "\"+y")
vim.keymap.set("v", "<leader>yy", "\"+y")
vim.keymap.set("n", "<leader>pp", "\"+p")
vim.keymap.set("v", "<leader>pp", "\"+p")
-- move line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- delete to null register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
-- change indentation 
vim.keymap.set("v", "<leader><", "<Vgv")
vim.keymap.set("v", "<leader>>", ">Vgv")
vim.keymap.set("n", "<leader>fc", function ()
  local ft = vim.bo.filetype
  if ft == "c" or ft == "cpp" then
    vim.cmd("%!clang-format")
  elseif ft == "rust" then
    vim.cmd("%!rustfmt")
  end
end)
-- tab hotkeys
vim.keymap.set("n", "<leader>tn", function() vim.cmd("tabn") end)
vim.keymap.set("n", "<leader>tp", function() vim.cmd("tabp") end)
vim.keymap.set("n", "<leader>tc", function() vim.cmd("tabc") end)
-- buffer hotkeys
vim.keymap.set("n", "<leader>bn", function() vim.cmd("bn") end)
vim.keymap.set("n", "<leader>bp", function() vim.cmd("bp") end)
vim.keymap.set("n", "<leader>bc", function() vim.cmd("bd") end)
-- quickfix hotkeys
vim.keymap.set("n", "<leader>cc", function() vim.cmd("cc") end)
vim.keymap.set("n", "<leader>cn", function() vim.cmd("cn") end)
vim.keymap.set("n", "<leader>cp", function() vim.cmd("cp") end)
-- alt + [wasd] to resize to adjecent window 
vim.keymap.set("n", "<M-W>", "<C-w>+")
vim.keymap.set("n", "<M-A>", "<C-w>5<")
vim.keymap.set("n", "<M-S>", "<C-w>-")
vim.keymap.set("n", "<M-D>", "<C-w>5>")
vim.keymap.set("t", "<M-W>", "<C-w>+")
vim.keymap.set("t", "<M-A>", "<C-w>5<")
vim.keymap.set("t", "<M-S>", "<C-w>-")
vim.keymap.set("t", "<M-D>", "<C-w>5>")
-- alt + [hjkl] to move to adjecent window 
vim.keymap.set("n", "<M-w>", "<C-w>k")
vim.keymap.set("n", "<M-a>", "<C-w>h")
vim.keymap.set("n", "<M-s>", "<C-w>j")
vim.keymap.set("n", "<M-d>", "<C-w>l")
vim.keymap.set("t", "<M-w>", "<C-w>k")
vim.keymap.set("t", "<M-a>", "<C-w>h")
vim.keymap.set("t", "<M-s>", "<C-w>j")
vim.keymap.set("t", "<M-d>", "<C-w>l")
