
vim.pack.add({
  "https://github.com/kyazdani42/nvim-web-devicons",
  "https://github.com/folke/trouble.nvim",
})

require("trouble").setup()
vim.keymap.set("n", "<leader>tt", "<cmd>Trouble telescope toggle focus=true follow=true<CR>")
vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true follow=true<CR>")
vim.keymap.set("n", "<leader>tw", "<cmd>Trouble diagnostics toggle focus=true follow=true<CR>")
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix toggle focus=true follow=true<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=true follow=true<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd>Trouble lsp_references toggle focus=true follow=true<CR>")
