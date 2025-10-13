-- Git signs configuration
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local map = function(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next hunk")

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Previous hunk")

		-- Actions
		map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage hunk")
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset hunk")
		map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, "Blame line")
		map("n", "<leader>hd", gs.diffthis, "Diff this")

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
	end,
})
