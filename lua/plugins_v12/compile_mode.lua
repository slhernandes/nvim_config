vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/m00qek/baleia.nvim",
  "https://github.com/ej-shafran/compile-mode.nvim"
})

vim.g.compile_mode = {
  baleia_setup = true,
  default_command = "",
  recompile_no_fail = true,
  auto_jump_to_first_error = false
}
vim.keymap.set("n", "<leader>mm", ":15Compile<CR>")
vim.keymap.set("n", "<leader>mq",
               function() require("compile-mode").add_to_qflist() end)
vim.keymap.set("n", "<leader>mr", ":15Recompile<CR>")
