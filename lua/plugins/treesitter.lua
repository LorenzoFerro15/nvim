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

		local indent_filetypes = {
			lua = true,
			go = true,
			javascript = true,
			typescript = true,
			javascriptreact = true,
			typescriptreact = true,
			html = true,
			css = true,
			json = true,
		}

		-- Preserve native indentation outside these filetypes and when no parser is available.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("config_treesitter", { clear = true }),
			callback = function(args)
				local started = pcall(vim.treesitter.start, args.buf)
				if started and indent_filetypes[vim.bo[args.buf].filetype] then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
