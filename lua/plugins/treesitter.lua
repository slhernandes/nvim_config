return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.install'.compilers = {"gcc-12", "clang", "gcc"}
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "cpp", "c", "lua", "vim", "vimdoc", "query", "latex"
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {"javascript"},
        highlight = {enable = true, additional_vim_regex_highlighting = false}
      }
    end
  }, {
    "nvim-treesitter/nvim-treesitter-textobjects",
    ft = {"md", "norg"},
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {enable = true},
        textobjects = {
          move = {
            enable = true,
            set_jumps = false, -- you can change this if you want.
            goto_next_start = {
              ["]c"] = {query = "@code_cell.inner", desc = "next code block"}
            },
            goto_previous_start = {
              ["[c"] = {
                query = "@code_cell.inner",
                desc = "previous code block"
              }
            }
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["ic"] = {query = "@code_cell.inner", desc = "in block"},
              ["ac"] = {query = "@code_cell.outer", desc = "around block"}
            },
            include_surrounding_whitespace = false
          }
        }
      }
    end
  }
}
