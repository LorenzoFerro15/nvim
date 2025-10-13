return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
		{ "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
		{ "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
		{ "<leader>wd", "<cmd>AutoSession delete<CR>", desc = "Delete session" },
	},
	opts = {
		session_lens = {
			picker = "telescope",
			mappings = {
				delete_session = { "i", "<C-d>" },
				alternate_session = { "i", "<leader>wd" },
				copy_session = { "i", "<C-y>" },
			},
			picker_opts = {
				border = true,
				layout_config = {
					width = 0.8,
					height = 0.5,
				},
			},
			load_on_setup = true,
		},
	},
}
