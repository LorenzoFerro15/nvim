return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "python", "go", "javascript", "typescript" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
