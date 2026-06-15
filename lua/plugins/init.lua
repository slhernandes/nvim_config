local plugins = {
  "autoformat", "colorizer", "colorschemes", "blink", "context", "devicons",
  "fugitive", "harpoon", "lsp", "lualine", "ocaml", "python", "snacks",
  "telescope", "toggleterm", "treesitter", "trouble", "undotree", "yazi"
}
for _, plugin in ipairs(plugins) do require("plugins." .. plugin) end
vim.api.nvim_create_user_command("PackUpdate", ":=vim.pack.update()", {})
