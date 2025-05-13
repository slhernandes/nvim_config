return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
                   {desc = '[h]arpoon [a]dd'})
    vim.keymap.set("n", "<leader>he",
                   function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                   {desc = '[h]arpoon [e]dit'})

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
                   {desc = '[h]arpoon [p]rev'})
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
                   {desc = '[h]arpoon [n]ext'})
  end
}
