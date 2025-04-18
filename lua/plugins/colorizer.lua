return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require("colorizer").setup({'css', 'html', 'conf', 'lua', 'tmux'}, {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = 'background'
    })
  end
}
