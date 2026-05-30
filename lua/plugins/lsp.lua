vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/mason-org/mason.nvim"
})

require("mason").setup({ui = {border = "rounded"}})

local servers = {
  ty = {},
  zls = {},
  tinymist = {},
  clangd = {},
  texlab = {},
  gopls = {},
  hyprls = {},
  qmlls = {cmd = {"qmlls", "-E"}, root_markers = {".qmlls.ini"}},
  rust_analyzer = {
    settings = {
      diagnostics = {disabled = {"unlinked-file"}},
      root_dir = ".",
      init_options = {detachedFiles = {"/tmp/file.rs"}}
    }
  },
  lua_ls = {
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
    settings = {
      Lua = {diagnostics = {globals = {'vim'}, disable = {'missing-fields'}}}
    }
  }
}

for _, method in ipairs({'textDocument/diagnostic', 'workspace/diagnostic'}) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then return end
    return default_diagnostic_handler(err, result, context, config)
  end
end

vim.diagnostic.config({float = {border = "rounded"}})

local lsp_attach = function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K",
                 function() vim.lsp.buf.hover({border = "rounded"}) end, opts)
  vim.keymap.set('n', '<Leader>k', function() vim.diagnostic.open_float() end,
                 {desc = 'Show line diagnostics'})
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
                 opts)
  vim.keymap.set("n", "<leader>vsh", function()
    vim.lsp.buf.signature_help({border = "rounded"})
  end, opts)
end

for server_name, server_cfg in pairs(servers) do
  server_cfg.capabilities = require("cmp_nvim_lsp").default_capabilities()
  if server_name == 'clangd' then
    -- prevent crashing when encountering non utf-8 characters (e.g. ”)
    server_cfg.capabilities.offsetEncoding = "utf-32"
  end
  server_cfg.on_attach = server_cfg.on_attach or lsp_attach
  server_cfg.root_markers = server_cfg.root_markers or {".git"}
  vim.lsp.enable(server_name)
  vim.lsp.config(server_name, server_cfg)
end
