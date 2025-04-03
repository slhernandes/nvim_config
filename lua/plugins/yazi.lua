return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    -- check the installation instructions at
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim"
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>pv",
      mode = {"n", "v"},
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file"
    }, {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory"
    }, {"<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session"}
  },
  ---@type YaziConfig | {}
  opts = {open_for_directories = true, keymaps = {show_help = "<f1>"}},
  init = function() vim.g.loaded_netrwPlugin = 1 end
}
