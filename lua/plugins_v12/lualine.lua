vim.pack.add({
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/kyazdani42/nvim-web-devicons',
  "https://github.com/folke/noice.nvim",
})

require("nvim-web-devicons").setup({})
local icons = require("nvim-nonicons")
local nonicons_extention = require("nvim-nonicons.extentions.lualine")

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {left = '|', right = '|'},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {statusline = {}, winbar = {}},
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {statusline = 100, tabline = 100, winbar = 100}
  },
  sections = {
    lualine_a = {nonicons_extention.mode},
    lualine_b = {{"branch", icon = icons.get("git-branch")}, 'diff'},
    lualine_c = {'buffers'},
    lualine_x = {'diagnostics', {
      function()
        local mode = require("noice").api.statusline.mode.get()
        return string.gsub(mode, "recording ", "🔴")
      end,
      cond = require("noice").api.statusline.mode.has,
      color = { fg = "#ff9e64" },
    }
  },
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
