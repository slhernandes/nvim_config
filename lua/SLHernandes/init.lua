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

-- GRAVEYARDS SECTION
--
-- ocp-indent of ocaml
-- vim.api.nvim_exec2([[
--  set rtp^="/home/samuelhernandes/.opam/default/share/ocp-indent/vim"
--  ]],
--  { output= false }
-- )
-- Hyprlang LSP
-- vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
--   pattern = {"*.hl", "hypr*.conf"},
--   callback = function(event)
--     print(string.format("starting hyprls for %s", vim.inspect(event)))
--     vim.lsp.start {
--       name = "hyprlang",
--       cmd = {"hyprls"},
--       root_dir = vim.fn.getcwd(),
--     }
--   end
-- })
