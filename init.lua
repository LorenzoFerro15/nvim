require("config.lazy")
require("git-config")

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.termguicolors = true

vim.opt.autoindent = true

vim.cmd [[
  syntax enable
  colorscheme retrobox
]]
