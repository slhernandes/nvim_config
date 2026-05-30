vim.pack.add({
  "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp"
})
local cmp = require("blink.cmp")

cmp.build():pwait()
cmp.setup({
  completion = {
    ghost_text = {enabled = true},
    menu = {
      draw = {
        components = {
          label = {
            text = function(ctx)
              local label = ctx.label .. ctx.label_detail
              if #label <= 25 then return label end
              return label:sub(1, 24) .. "…"
            end
          }
        }
      }
    },
    documentation = {window = {max_width = 25}, auto_show = false}
  }
})
