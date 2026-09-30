return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	keys = {
		{ "<leader>mp", "<cmd>RenderMarkdown preview<CR>", desc = "Toggle Markdown side preview" },
		{ "<leader>mt", "<cmd>RenderMarkdown buf_toggle<CR>", desc = "Toggle Markdown rendering" },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
}
