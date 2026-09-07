-- Keymaps configuration

local map = vim.keymap.set

-- General Keymaps
-- Clear search highlights on <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Keep visual selection when indenting
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Tab management
map("n", "<leader>ta", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })

-- File operations in current directory
map("n", "<leader>e", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "Edit file in current dir" })
map("n", "<leader>t", [[:tabe <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "New tab in current dir" })
map("n", "<leader>s", [[:split <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "Split in current dir" })

-- LSP keymaps (set on LspAttach autocmd)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
		map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Goto definition" }))
		map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto declaration" }))
		map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Goto implementation" }))
		map("n", "go", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Goto type definition" }))
		map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Goto references" }))
		map("n", "gs", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
		map("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		map("n", "<F4>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
		map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
		map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
	end,
})

-- Format (with conform.nvim)
map({ "n", "v" }, "<leader>mp", function()
	require("conform").format({ lsp_fallback = true, timeout_ms = 1000 })
end, { desc = "Format file or range" })

-- Session management
map("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "Session search" })
map("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
map("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete session" })

