require("SLHernandes.remap")
require("SLHernandes.set")
require("SLHernandes.template")
require("SLHernandes.augroup")

vim.api.nvim_exec2([[
function OpenMarkdownPreview (url)
  execute "silent ! firefox --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
]], {output = false})
