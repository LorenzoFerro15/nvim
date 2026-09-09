return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local map = vim.keymap.set

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		-- Selection text objects (function, class, parameter, conditional, loop)
		map({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end, { desc = "Around function" })
		map({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end, { desc = "Inner function" })
		map({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end, { desc = "Around class" })
		map({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end, { desc = "Inner class" })
		map({ "x", "o" }, "aa", function()
			select.select_textobject("@parameter.outer", "textobjects")
		end, { desc = "Around parameter" })
		map({ "x", "o" }, "ia", function()
			select.select_textobject("@parameter.inner", "textobjects")
		end, { desc = "Inner parameter" })
		map({ "x", "o" }, "ai", function()
			select.select_textobject("@conditional.outer", "textobjects")
		end, { desc = "Around conditional" })
		map({ "x", "o" }, "ii", function()
			select.select_textobject("@conditional.inner", "textobjects")
		end, { desc = "Inner conditional" })
		map({ "x", "o" }, "al", function()
			select.select_textobject("@loop.outer", "textobjects")
		end, { desc = "Around loop" })
		map({ "x", "o" }, "il", function()
			select.select_textobject("@loop.inner", "textobjects")
		end, { desc = "Inner loop" })

		-- Movement keymaps
		map({ "n", "x", "o" }, "]m", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next function start" })
		map({ "n", "x", "o" }, "[m", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Prev function start" })
		map({ "n", "x", "o" }, "]M", function()
			move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Next function end" })
		map({ "n", "x", "o" }, "[M", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Prev function end" })
	end,
}
