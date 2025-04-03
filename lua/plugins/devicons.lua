return {
  {
    'yamatsum/nvim-nonicons',
    dependencies = {'kyazdani42/nvim-web-devicons'},
    config = function() require('nvim-nonicons').setup({}) end
  }
}
