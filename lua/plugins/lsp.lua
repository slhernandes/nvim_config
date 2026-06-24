vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim"
})

require("mason").setup({ ui = { border = "rounded" } })

local servers = {
  ty = {},
  zls = {},
  tinymist = {},
  fennel_ls = {},
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
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path .. '/.luarc.json') or
            vim.uv.fs_stat(path .. '/.luarc.jsonc') then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config
        .settings.Lua, {
          runtime = { version = 'LuaJIT' },
          workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } }
        })
    end,
    settings = {
      Lua = { diagnostics = { globals = { 'vim' }, disable = { 'missing-fields' } } }
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

vim.diagnostic.config({ float = { border = "rounded" } })

local lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K",
    function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
  vim.keymap.set('n', '<Leader>k', function() vim.diagnostic.open_float() end,
    { desc = 'Show line diagnostics' })
  vim.keymap.set('n', "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
    opts)
  vim.keymap.set("n", "<leader>vsh", function()
    vim.lsp.buf.signature_help({ border = "rounded" })
  end, opts)
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help({ border = "rounded" })
  end, opts)
  if client.name == "qmlls" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

for server_name, server_cfg in pairs(servers) do
  server_cfg.on_attach = server_cfg.on_attach or lsp_attach
  server_cfg.root_markers = server_cfg.root_markers or { ".git" }
  vim.lsp.enable(server_name)
  vim.lsp.config(server_name, server_cfg)
end
