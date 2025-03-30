return {
  "ej-shafran/compile-mode.nvim",
  branch = "latest",
  dependencies = {
    "nvim-lua/plenary.nvim", {"m00qek/baleia.nvim", version = "*"}
  },
  config = function()
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
  end
}
