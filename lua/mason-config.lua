require("mason").setup({
	ui = {
		icons = {
		    package_installed = "✓",
		    package_pending = "➜",
		    package_uninstalled = "✗"
		}
	}
})
require('mason-lspconfig').setup({
  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- this is the "custom handler" for `biome`
    biome = function()
      require('lspconfig').biome.setup({
        single_file_support = false,
        on_attach = function(client, bufnr)
          print('hello biome')
        end
      })
    end,
  }
})
local allow_format = function(servers)
  return function(client) return vim.tbl_contains(servers, client.name) end
end
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    client.server_capabilities.semanticTokensProvider = nil
  end
})
require('lspconfig').lua_ls.setup({
  on_attach = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
require('lspconfig').lua_ls.setup({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
  end,
})
local buffer_autoformat = function(bufnr)
  local group = 'lsp_autoformat'
  vim.api.nvim_create_augroup(group, {clear = false})
  vim.api.nvim_clear_autocmds({group = group, buffer = bufnr})

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = group,
    desc = 'LSP format on save',
    callback = function()
      -- note: do not enable async formatting
      vim.lsp.buf.format({async = false, timeout_ms = 10000})
    end,
  })
end

require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup{}
	end,
}

require('lspconfig').biome.setup({
  single_file_support = false,
  on_attach = function(client, bufnr)
    print('hello biome')
  end
})

local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'nvim_lua'},
    {name = 'calc'},
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  completiopn = {
    keyword_length = 1,
    keyword_pattern = ".*",
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-f>'] = cmp.mapping(function(fallback)
      local luasnip = require('luasnip')
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<C-b>'] = cmp.mapping(function(fallback)
      local luasnip = require('luasnip')
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1
      if col == 0 then
        fallback()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
})