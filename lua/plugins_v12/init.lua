local plugins = {
"colorschemes",
"colorizer",
"compile_mode",
"context",
"devicons",
"fugitive",
"harpoon",
"snacks",
"lualine",
"telescope",
"toggleterm",
-- "treesitter",
"trouble",
"undotree",
"yazi",
"showkeys",
"completion",
"lsp",
"ocaml",
"noice",
}
for _, plugin in ipairs(plugins) do
  require("plugins_v12." .. plugin)
end
