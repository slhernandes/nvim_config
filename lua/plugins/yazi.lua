vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/mikavilpas/yazi.nvim"
})

vim.keymap.set({"n", "v"}, "<leader>pv", "<cmd>Yazi<cr>",
               {silent = true, desc = "Open yazi at the current file"})
require("yazi").setup({open_for_directories = false})
