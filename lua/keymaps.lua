-- Keymaps configuration

local map = vim.keymap.set

-- Tab management
map("n", "<leader>ta", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- File operations in current directory
map("n", ",e", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "Edit file in current dir" })
map("n", ",t", [[:tabe <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "New tab in current dir" })
map("n", ",s", [[:split <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "Split in current dir" })

-- LSP keymaps (set on LspAttach autocmd)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "go", vim.lsp.buf.type_definition, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "gs", vim.lsp.buf.signature_help, opts)
		map("n", "<F2>", vim.lsp.buf.rename, opts)
		map("n", "<F4>", vim.lsp.buf.code_action, opts)
	end,
})

-- Format (with conform.nvim)
map({ "n", "v" }, "<leader>mp", function()
	require("conform").format({ lsp_fallback = true, timeout_ms = 1000 })
end, { desc = "Format file or range" })

-- Session management
map("n", "<leader>wr", "<cmd>SessionSearch<CR>", { desc = "Session search" })
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session" })
map("n", "<leader>wd", "<cmd>SessionDelete<CR>", { desc = "Delete session" })

