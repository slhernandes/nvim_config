return {
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    lazy = true,
    version = '*',
    --  dependencies = { 'plenary.nvim' },
    --  version = 'v7.0.0',
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.ui.calendar'] = {},
          ['core.dirman'] = {config = {workspaces = {uni = '~/notes/uni'}}}
        }
      }
    end
  }
}
