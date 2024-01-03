local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>pl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
--require("telescope").setup {
--  defaults = {
--    preview = {
--      filesize_hook = function(filepath, bufnr, opts)
--        local max_bytes = 10000
--        local cmd = {"head", "-c", max_bytes, filepath}
--        require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
--      end
--    },
--    vimgrep_arguments = {
--      "rg",
--      "--no-heading",
--      "--with-filename",
--      "--line-number",
--      "--column",
--      "--hidden",
--      "--smart-case"
--    },
--    selection_strategy = "reset",
--    sorting_strategy = "ascending",
--    file_ignore_patterns = {
--      "dist/.*",
--      "%.git/.*",
--      "%.vim/.*",
--      "node_modules/.*",
--      "%.idea/.*",
--      "%.vscode/.*",
--      "%.history/.*"
--    },
--    layout_config = {
--      vertical = {
--        mirror = true
--      },
--      width = 0.93,
--      prompt_position = "top"
--    },
--  }
--}
