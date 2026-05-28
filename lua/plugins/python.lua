vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "jupynvim" and ev.data.kind ~= "delete" then
      local install = loadfile(ev.data.path .. "/lua/jupynvim/install.lua")()
      local spec = ev.data.spec
      spec.dir = ev.data.path
      install.run(spec)
      print("Jupynvim installation done")
    end
  end
})
vim.pack.add({ "https://github.com/sheng-tse/jupynvim.git" })
require("jupynvim").setup({
  log_level = "info",
  image_renderer = "placeholder", -- "placeholder", "kitty", or "chafa"
  image_rows = 16,
  image_cols = 48
})
