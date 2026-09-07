-- Set leader keys before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Load plugin manager
require("config.lazy")

-- Load keymaps
require("keymaps")

-- Editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.undofile = true

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Window split settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace visualization
vim.o.listchars = "tab:➜ ,trail:·,extends:›,precedes:‹,nbsp:␣"
vim.o.list = true

-- Session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Set colorscheme
vim.cmd.colorscheme("nord")

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
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
