vim.pack.add({
  "https://github.com/hrsh7th/cmp-calc",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/onsails/lspkind.nvim",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/hrsh7th/cmp-omni",
  "https://github.com/hrsh7th/nvim-cmp",
})

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end,
{silent = true})
vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end,
{silent = true})
vim.keymap.set({"i", "s"}, "<C-E>", function()
  if ls.choice_active() then ls.change_choice(1) end
end, {silent = true})

-- go completion
ls.add_snippets("go", {
  s("iferr", fmt([[
  if {err} != nil {{
    return {err}
  }}
  ]], {err = i(1, "err")}, {repeat_duplicates = true}))
})

-- rust completion
local types = {"usize", "i64", "i32"};
for _, value in ipairs(types) do
  ls.add_snippets("rust", {
    s("read" .. value, fmt(string.format([[
    {buf}.clear();
    stdin.read_line(&mut {buf})?;
    let {n} = buf.trim().parse::<%s>().unwrap();
    ]], value), {buf = i(1, "buf"), n = i(2, "n")},
    {repeat_duplicates = true}))
  })
  ls.add_snippets("rust", {
    s("read" .. value .. "vec", fmt(string.format([[
    {buf}.clear();
    stdin.read_line(&mut {buf})?;
    let {n} = buf.trim().split(' ').map(|x| x.trim().parse::<%s>().unwrap()).collect::<Vec<_>>();
    ]], value), {buf = i(1, "buf"), n = i(2, "n")},
    {repeat_duplicates = true}))
  })
end

vim.o.pumheight = 15
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ['<C-n>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.complete()
  }),
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'otter'},
    {name = 'buffer'}, {name = 'path'}, {name = 'treesitter'},
    {name = 'calc'},
    {
      name = 'omni',
      option = {disable_omnifuncs = {'v:lua.vim.lsp.omnifunc'}}
    }
  }, {{name = 'buffer'}}),
  formatting = {
    fields = {'kind', 'abbr', 'menu'},
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 25, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      before = function(_, vim_item)
        if vim.bo.filetype ~= "ocaml" then vim_item.menu = "" end
        return vim_item
      end
    })
  }
})
