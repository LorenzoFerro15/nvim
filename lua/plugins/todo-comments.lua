return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
		{ "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
		{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
	},
}
