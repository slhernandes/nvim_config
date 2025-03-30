return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
      'luc-tielen/telescope_hoogle'
    },
    config = function()
      local icons = require("nvim-nonicons")
      local action_set = require("telescope.actions.set")
      require("telescope").setup({
        defaults = {
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          selection_caret = " ❯ ",
          entry_prefix = "   "
        },
        extensions = {fzf = {}, hoogle = {}},
        pickers = {
          help_tags = {
            mappings = {
              i = {
                ["<CR>"] = function(prompt_bufnr)
                  action_set.select(prompt_bufnr, "tab")
                end
              }
            },
            layout_config = {preview_width = 0.65}
          },
          man_pages = {
            sections = {"1", "3"},
            mappings = {
              i = {
                ["<CR>"] = function(prompt_bufnr)
                  action_set.select(prompt_bufnr, "tab")
                end
              }
            },
            layout_config = {preview_width = 0.35}
          }
        }
      })
      local builtin = require('telescope.builtin')
      local themes = require('telescope.themes')
      require('telescope').load_extension('hoogle')
      require('telescope').load_extension('fzf')
      vim.keymap.set('n', '<leader>pf', function()
        local opts = themes.get_ivy({
          hidden = true,
          no_ignore = true,
          no_ignore_parents = true
        })
        builtin.find_files(opts)
      end, {})
      vim.keymap.set('n', '<C-p>', function()
        local opts = themes.get_ivy()
        builtin.git_files(opts)
      end, {})
      vim.keymap.set('n', '<leader>ps', function()
        local opts = themes.get_ivy({search = vim.fn.input("󰑑 ❯ ")})
        builtin.grep_string(opts)
      end)
      vim.keymap.set('n', '<leader>pl', function()
        local opts = themes.get_ivy()
        builtin.live_grep(opts)
      end, {})
      vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>pm', builtin.man_pages, {})
      vim.keymap.set('n', '<leader>pd', '<cmd>Telescope hoogle<CR>', {})
    end
  }
}
