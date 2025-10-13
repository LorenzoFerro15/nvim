local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = { { import = "plugins" } },
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

local builtin = require("telescope.builtin")
local map = vim.keymap.set
map("n", "<C-p>", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", ",e", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })
map("n", ",t", [[:tabe <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })
map("n", ",s", [[:split <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })

