return {
  'mason-org/mason.nvim',
  dependencies = {
    'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/nvim-cmp'
  },
  config = function()
    require("mason").setup({ ui = { border = "rounded" } })

    local servers = {
      zls = {},
      tinymist = {},
      clangd = {},
      texlab = {},
      gopls = {},
      hyprls = {},
      qmlls = { cmd = { "qmlls", "-E" }, root_markers = { ".qmlls.ini" } },
      rust_analyzer = {
        settings = {
          diagnostics = { disabled = { "unlinked-file" } },
          root_dir = ".",
          init_options = { detachedFiles = { "/tmp/file.rs" } }
        }
      },
      -- pylsp = {
      --   settings = {
      --     pylsp = {
      --       plugins = {
      --         jedi_completion = {
      --           include_class_objects = true,
      --           include_function_objects = true,
      --           eager = true
      --         }
      --       }
      --     }
      --   }
      -- },
      lua_ls = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or
                vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force',
            client.config
            .settings.Lua, {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME }
              }
            })
        end,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' }, disable = { 'missing-fields' } }
          }
        }
      }
    }

    for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
      local default_diagnostic_handler = vim.lsp.handlers[method]
      vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then return end
        return default_diagnostic_handler(err, result, context, config)
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local capabilities_clangd = require("cmp_nvim_lsp").default_capabilities()
    capabilities_clangd.offsetEncoding = 'utf-32'

    local lsp_attach = function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K",
        function() vim.lsp.buf.hover({ border = "rounded" }) end,
        opts)
      vim.keymap.set("n", "<leader>vws",
        function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1 }) end,
        opts)
      vim.keymap.set("n", "]d",
        function() vim.diagnostic.jump({ count = -1 }) end, opts)
      vim.keymap.set("n", "<leader>vca",
        function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr",
        function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
        opts)
      vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end, opts)
      vim.keymap.set("n", "<leader>vsh", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end, opts)
    end

    for server_name, server_cfg in pairs(servers) do
      if server_name == 'clangd' then
        -- prevent crashing when encountering non utf-8 characters (e.g. ”)
        server_cfg.capabilities = capabilities_clangd
      else
        server_cfg.capabilities = capabilities
      end
      server_cfg.on_attach = server_cfg.on_attach or lsp_attach
      server_cfg.root_markers = server_cfg.root_markers or { ".git" }
      vim.lsp.enable(server_name)
      vim.lsp.config(server_name, server_cfg)
    end
  end
}
