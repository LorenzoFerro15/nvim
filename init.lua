require("config.lazy")
require("git-config")

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 3
opt.autoindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect", "noinsert" }
opt.shortmess:append("c")
opt.updatetime = 300
opt.signcolumn = "yes"

vim.cmd("colorscheme retrobox")

local map = vim.keymap.set
map("n", "<leader>ta", ":$tabnew<CR>")
map("n", "<leader>tc", ":tabclose<CR>")
map("n", "<leader>to", ":tabonly<CR>")
map("n", "<leader>tn", ":tabn<CR>")
map("n", "<leader>tp", ":tabp<CR>")
map("n", "<leader>tmp", ":-tabmove<CR>")
map("n", "<leader>tmn", ":+tabmove<CR>")

vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	update_in_insert = true,
	underline = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

