return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        --    component_separators = { left = '', right = ''},
        --    section_separators = { left = '', right = ''},
        --    component_separators = { left = '', right = ''},
        --    section_separators = { left = '', right = ''},
        -- component_separators = { left = '/', right = '/'},
        -- section_separators = { left = '', right = ''},
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'buffers'},
        lualine_x = {'diagnostics'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {'filename'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
