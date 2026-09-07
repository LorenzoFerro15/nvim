return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
	},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
	},
	opts = {},
}
