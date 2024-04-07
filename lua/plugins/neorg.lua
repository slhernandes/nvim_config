return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    lazy = false,
    dependencies = { 'luarocks.nvim' },
    version = '*',
--  dependencies = { 'plenary.nvim' },
--  version = 'v7.0.0',
    config = function ()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.presenter'] = {
            config = {
              zen_mode = "zen-mode",
            }
          },
          ['core.ui.calendar'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                uni = '~/notes/uni',
              },
            },
          },
        },
      }
    end,
  }
}
