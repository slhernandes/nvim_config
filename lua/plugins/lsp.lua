return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'},
    {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-calc'},
    {'L3MON4D3/LuaSnip'}, {'onsails/lspkind.nvim'},
    {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-omni'}
  },
  config = function()
    for _, method in ipairs({'textDocument/diagnostic', 'workspace/diagnostic'}) do
      local default_diagnostic_handler = vim.lsp.handlers[method]
      vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then return end
        return default_diagnostic_handler(err, result, context, config)
      end
    end
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

    ls.add_snippets("go", {
      s("iferr", fmt([[
      if {err} != nil {{
        return {err}
      }}
      ]], {err = i(1, "err")}, {repeat_duplicates = true}))
    })

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls', 'rust_analyzer', 'clangd', 'pylsp', 'texlab'
      }
    })

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

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(_, bufnr)
      local opts = {buffer = bufnr, remap = false}

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K",
                     function() vim.lsp.buf.hover({border = "rounded"}) end,
                     opts)
      vim.keymap.set("n", "<leader>vws",
                     function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count = 1}) end,
                     opts)
      vim.keymap.set("n", "]d",
                     function() vim.diagnostic.jump({count = -1}) end, opts)
      vim.keymap.set("n", "<leader>vca",
                     function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr",
                     function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
                     opts)
      vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help({border = "rounded"})
      end, opts)
      vim.keymap.set("n", "<leader>vsh", function()
        vim.lsp.buf.signature_help({border = "rounded"})
      end, opts)
    end

    local function mark_wrap(f)
      return function()
        local cur_line = vim.api.nvim_exec2("echo line(\".\")", {output = true})
                             .output or "1"
        local cur_col = vim.api.nvim_exec2("echo col(\".\")", {output = true})
                            .output or "0"
        f()
        local lc = vim.api.nvim_buf_line_count(0)
        local cur_line_num = tonumber(cur_line) or 1
        if lc >= cur_line_num then
          vim.cmd("call setcursorcharpos(" .. cur_line .. ", " .. cur_col .. ")")
        else
          vim.cmd("norm G")
        end
      end
    end
    local use_default = {
      lua_ls = {
        enabled = false,
        filetype = "lua",
        format = mark_wrap(function()
          vim.cmd([[silent exec "%!lua-format --indent-width=2"]])
        end)
      },
      ocaml_lsp = {
        enabled = false,
        filetype = "ocaml",
        format = mark_wrap(function()
          local format_cmd = "%!ocamlformat -"
          format_cmd = format_cmd .. " --enable-outside-detected-project"
          format_cmd = format_cmd .. " -p janestreet"
          format_cmd = format_cmd .. " --if-then-else=fit-or-vertical"
          format_cmd = format_cmd .. " -m 80"
          format_cmd = format_cmd .. " --impl"
          vim.cmd(string.format([[
            silent exec "%s"
          ]], format_cmd))
        end)
      },
      bashls = {
        enabled = false,
        filetype = {"bash", "sh", "zsh"},
        format = mark_wrap(function()
          vim.cmd([[silent exec "%!beautysh -i 2 -"]])
        end)
      }
    }

    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Autoformatting for buffer without LSP",
      group = vim.api.nvim_create_augroup('autoformatter', {clear = false}),
      callback = function(args)
        local function check_ft(in_ft, data)
          local ret = false
          if type(data) == "table" then
            for _, i in ipairs(data) do
              if in_ft == i then
                ret = true
                break
              end
            end
          elseif type(data) == "string" then
            ret = in_ft == data
          end
          return ret
        end
        for _, v in pairs(use_default) do
          if check_ft(vim.bo.filetype, v.filetype) and not v.enabled then
            vim.keymap.set({"n", "v"}, "<leader>fc", v.format)
            if (tonumber(vim.fn.system({'wc', '-l', vim.fn.expand('%')}):match(
                             '%d+')) or 0) <= 1000 then
              vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup(vim.bo.filetype ..
                                                        'formatter', {}),
                buffer = args.buf,
                callback = function()
                  v.format()
                  if vim.v.shell_error > 0 then
                    print("Error occured, undo.")
                    vim.cmd [[undo]]
                  end
                end
              })
            end
          end
        end
      end
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('autoformatter', {clear = false}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if not client:supports_method('textDocument/willSaveWaitUntil') and
            client:supports_method('textDocument/formatting') then
          local is_enabled = use_default[client.name] or {enabled = true}
          if is_enabled.enabled then
            vim.keymap.set({"n", "v"}, "<leader>fc",
                           mark_wrap(function() vim.lsp.buf.format() end))
            if (tonumber(vim.fn.system({'wc', '-l', vim.fn.expand('%')}):match(
                             '%d+')) or 0) <= 1000 then
              vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', {clear = false}),
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({
                    bufnr = args.buf,
                    id = client.id,
                    timeout_ms = 1000
                  })
                end
              })
            end
          end
        end
      end
    })

    local lspconfig = require('lspconfig')

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = lsp_attach,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if vim.uv.fs_stat(path .. '/.luarc.json') or
              vim.uv.fs_stat(path .. '/.luarc.jsonc') then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config
                                                             .settings.Lua, {
          runtime = {version = 'LuaJIT'},
          workspace = {checkThirdParty = false, library = {vim.env.VIMRUNTIME}}
        })
      end,
      settings = {Lua = {}}
    })

    lspconfig.clangd
        .setup({capabilities = capabilities, on_attach = lsp_attach})

    lspconfig.texlab
        .setup({capabilities = capabilities, on_attach = lsp_attach})

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = lsp_attach
    })

    lspconfig.pylsp.setup({
      capabilities = capabilities,
      on_attach = lsp_attach,
      settings = {
        pylsp = {
          plugins = {
            jedi_completion = {
              include_class_objects = true,
              include_function_objects = true,
              eager = true
            }
          }
        }
      }
    })

    lspconfig.gopls.setup({capabilities = capabilities, on_attach = lsp_attach})

    lspconfig.hyprls
        .setup({capabilities = capabilities, on_attach = lsp_attach})
  end
}
