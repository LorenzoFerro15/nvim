return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = {},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- Formatters & Linters (LSPs are managed by mason-lspconfig)
				"stylua",
				"prettier",
				"black",
				"isort",
				"goimports",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig.util.default_config.capabilities,
				cmp_nvim_lsp.default_capabilities()
			)

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "gopls" },
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									workspace = {
										checkThirdParty = false,
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
