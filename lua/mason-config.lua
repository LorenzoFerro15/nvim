-- Mason UI setup
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- LSP Server setup using mason-lspconfig
require("mason-lspconfig").setup({
  handlers = {
    -- Default handler for all servers
    function(server_name)
      local ok, server = pcall(require, "lspconfig." .. server_name)
      if ok then
        server.setup({})
      end
    end,

    -- Custom setup for biome
    biome = function()
      local biome = require("lspconfig.biome")
      biome.setup({
        single_file_support = false,
        on_attach = function(client, bufnr)
          print("hello biome")
        end,
      })
    end,

    -- Custom setup for lua_ls
    lua_ls = function()
      local lua_ls = require("lspconfig.lua_ls")
      lua_ls.setup({
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentFormattingRangeProvider = false
        end,
      })
    end,
  },
})

-- Disable semantic tokens globally on LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- Autoformat on save
local buffer_autoformat = function(bufnr)
  local group = "lsp_autoformat"
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = group,
    desc = "LSP format on save",
    callback = function()
      vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end,
  })
end

-- CMP setup
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "calc" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  completion = {
    keyword_length = 1,
    keyword_pattern = ".*",
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-f>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-b>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      local col = vim.fn.col(".") - 1
      local line = vim.fn.getline(".")
      if col == 0 or line:sub(col, col):match("%s") then
        fallback()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
})

