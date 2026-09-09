return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit status" },
	},
	opts = {
		integrations = {
			diffview = true,
			telescope = true,
		},
	},
}
