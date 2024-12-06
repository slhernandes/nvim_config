return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local dir_fn = function ()
      local width  = vim.api.nvim_win_get_width(0)
      local height = vim.api.nvim_win_get_height(0)
      local width_px = width * 10
      local height_px = height * 20
      if width_px >= height_px then
        return "vertical"
      else
        return "horizontal"
      end
    end
    require("toggleterm").setup({
      direction = dir_fn(),
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        local width  = vim.api.nvim_win_get_width(0)
        local height = vim.api.nvim_win_get_height(0)
        if term.direction == "horizontal" then
          return height/4
        elseif term.direction == "vertical" then
          return 2*width/5
        end
      end,
      open_mapping = nil, -- no default open mapping
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = false,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      close_on_exit = true, -- close the terminal window when the process exits
      -- Change the default shell. Can be a string or a function returning a string
      shell = vim.o.shell,
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      -- This field is only relevant if direction is set to 'float'
    })

    -- dynamic window size and direction mapping
    vim.keymap.set({"n", "i"}, "<M-t>", function ()
      local width  = vim.api.nvim_win_get_width(0)
      local height = vim.api.nvim_win_get_height(0)
      local direction = dir_fn()
      local size = 0.0
      if direction == "horizontal" then
        size = height/4
      elseif direction == "vertical" then
        size = 2*width/5
      end
    vim.cmd("ToggleTerm direction=" .. direction .. " size=" .. tostring(size))
    --print(width, height)
    --print("ToggleTerm direction=" .. direction .. " size=" .. tostring(size))
    end)
    vim.keymap.set("t", "<M-t>", "<Cmd>ToggleTerm<CR>")
  end,
}
