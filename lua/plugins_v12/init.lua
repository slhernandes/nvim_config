local plugins = {
  "autoformat", "colorizer", "colorschemes", "compile_mode", "completion",
  "context", "devicons", "fugitive", "harpoon", "lsp", "lualine", -- "noice",
  "ocaml", "python", "showkeys", "snacks", "telescope", "toggleterm",
  "treesitter", "trouble", "undotree", "yazi"
}
for _, plugin in ipairs(plugins) do require("plugins_v12." .. plugin) end
