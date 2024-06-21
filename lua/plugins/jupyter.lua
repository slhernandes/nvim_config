return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    dependencies =  { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function ()
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20

      -- keybindings
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
      { silent = true, desc = "Initialize the plugin" })
      vim.keymap.set("n", "<localleader>re", ":MoltenEvaluateOperator<CR>",
      { silent = true, desc = "run operator selection" })
      vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
      { silent = true, desc = "evaluate line" })
      vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
      { silent = true, desc = "re-evaluate cell" })
      vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
      { silent = true, desc = "evaluate visual selection" })

    end,
  },
  {
    'goerz/jupytext.vim',
    config = function ()
      vim.g.jupytext_enable = 1
      vim.g.jupytext_command = 'jupytext'
      vim.g.jupytext_fmt = 'md'
    end
  }
}
