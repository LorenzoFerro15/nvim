-- Load plugin manager
require("config.lazy")

-- Load keymaps
require("keymaps")

-- Editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 3
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.tabstop = 4
vim.o.listchars = 'space:·,tab:  '
vim.o.list = true

-- Session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Set colorscheme
vim.cmd.colorscheme 'melange'

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- Show diagnostics on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

