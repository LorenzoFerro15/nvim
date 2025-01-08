require("config.lazy")
require("git-config")
require("mason-config")
require("cmp-config")
-- require("tabby-conf")

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.termguicolors = true

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "80"
vim.api.nvim_set_option('updatetime', 300)
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
vim.opt.autoindent = true

vim.cmd [[
  syntax enable
  colorscheme retrobox
]]

-- local sign = function(opts)
--   vim.fn.sign_define(opts.name, {
--     texthl = opts.name,
--     text = opts.text,
--     numhl = ''
--   })
-- end

-- sign({name = 'DiagnosticSignError', text = '|'})
-- sign({name = 'DiagnosticSignWarn', text = '|'})
-- sign({name = 'DiagnosticSignHint', text = '|'})
-- sign({name = 'DiagnosticSignInfo', text = '|'})

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
]])
