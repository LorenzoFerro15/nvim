return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup()

		-- Automatically ensure common language parsers are installed
		local parsers = {
			"lua",
			"vim",
			"vimdoc",
			"bash",
			"python",
			"go",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"json",
			"yaml",
			"markdown",
			"markdown_inline",
		}
		local installed = {}
		for _, p in ipairs(ts.get_installed()) do
			installed[p] = true
		end
		local to_install = {}
		for _, p in ipairs(parsers) do
			if not installed[p] then
				table.insert(to_install, p)
			end
		end
		if #to_install > 0 then
			pcall(ts.install, to_install)
		end

		-- Enable treesitter syntax highlighting for all supported buffers
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})

		-- Enable treesitter-based indentation
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
