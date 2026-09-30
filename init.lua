-- Set leader keys before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

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
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Disable unused remote providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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

-- Fast keycode timeouts (responsive leader and which-key)
vim.opt.timeoutlen = 300

-- Load plugins after setting editor options
require("config.lazy")
require("keymaps")

-- Set colorscheme
vim.cmd.colorscheme("nord")

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- Autocommands
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	desc = "Auto-resize splits on window resize",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Close utility windows with <q>
vim.api.nvim_create_autocmd("FileType", {
	desc = "Close utility buffers with q",
	pattern = { "help", "lspinfo", "qf", "checkhealth", "man", "notify" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})
