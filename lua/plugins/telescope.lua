return {
  {
    'nvim-telescope/telescope.nvim', version = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'luc-tielen/telescope_hoogle'
    },
    config = function ()
      local icons = require("nvim-nonicons")
      require("telescope").setup({
        defaults = {
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          selection_caret = " ❯ ",
          entry_prefix = "   ",
        },
        extensions = {
          fzf = {},
          hoogle = {},
        }
      })
      local builtin = require('telescope.builtin')
      local themes = require('telescope.themes')
      require('telescope').load_extension('hoogle')
      require('telescope').load_extension('fzf')
      vim.keymap.set('n', '<leader>pf', function ()
        local opts = themes.get_ivy({
          hidden = true,
          no_ignore = true,
          no_ignore_parents = true
        })
        builtin.find_files(opts)
      end, {})
      vim.keymap.set('n', '<C-p>', function ()
        local opts = themes.get_ivy()
        builtin.git_files(opts)
      end, {})
      vim.keymap.set('n', '<leader>ps', function()
        local opts = themes.get_ivy({
          search = vim.fn.input("Grep > ") 
        })
        builtin.grep_string(opts)
      end)
      vim.keymap.set('n', '<leader>pl', function ()
        local opts = themes.get_ivy()
        builtin.live_grep(opts)
      end, {})
      vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>pd', '<cmd>Telescope hoogle<CR>', {})
    end,
  },
  {
    'axkirillov/easypick.nvim',
    dependencies = { 
      'nvim-telescope/telescope.nvim'
    },
    config = function ()
      local easypick = require("easypick")

      -- only required for the example to work
      -- local get_default_branch = "git remote show origin | grep 'HEAD branch' | cut -d' ' -f5"
      -- local base_branch = vim.fn.system(get_default_branch) or "main"

      easypick.setup({
        pickers = {
          -- add your custom pickers here
          {
            name = "man",
            command = "man -k .",
            action = function (prompt_bufnr)
              local ac = require("telescope.actions")
              local as = require("telescope.actions.state")
              ac.select_default:replace(function()
                ac.close(prompt_bufnr)
                local selection = as.get_selected_entry()
                local p1 = "(.*)%s%(.*%)%s+-.*$"
                local p2 = "%((%d%l*)%)"

                local page = {}
                for i in selection[1]:gmatch(p1) do
                  table.insert(page, i)
                end

                local sect = {}
                for i in selection[1]:gmatch(p2) do
                  table.insert(sect, i)
                end

                local cmd_str = "hide Man " .. sect[1] .. " " .. page[1]
                vim.cmd(cmd_str)
              end)
              return true
            end
          },
          -- below you can find some examples of what those can look like

          -- list files inside current folder with default previewer
          {
            -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
            name = "ls",
            -- the command to execute, output has to be a list of plain text entries
            command = "ls",
            -- specify your custom previwer, or use one of the easypick.previewers
            previewer = easypick.previewers.default()
          },

          -- diff current branch with base_branch and show files that changed with respective diffs in preview
          -- {
          --   name = "changed_files",
          --   command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
          --   previewer = easypick.previewers.branch_diff({base_branch = base_branch})
          -- },

          -- list files that have conflicts with diffs in preview
          -- {
          --   name = "conflicts",
          --   command = "git diff --name-only --diff-filter=U --relative",
          --   previewer = easypick.previewers.file_diff()
          -- },
        }
      })
      vim.keymap.set('n', '<leader>pm', '<cmd>Easypick man<CR>', {})
    end
  }
}
