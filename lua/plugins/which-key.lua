return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{ "<leader>c", group = "Code" },
			{ "<leader>f", group = "Find / Telescope" },
			{ "<leader>g", group = "Git / Diff" },
			{ "<leader>h", group = "Git Hunks" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>t", group = "Tabs" },
			{ "<leader>u", desc = "Undo Tree" },
			{ "<leader>w", group = "Session" },
			{ "<leader>x", group = "Trouble / Diagnostics" },
		},
	},
}
