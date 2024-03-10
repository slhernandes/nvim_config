return {
    'nvim-neorg/neorg',
    ft = 'norg',
    build = ':Neorg sync-parsers',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
