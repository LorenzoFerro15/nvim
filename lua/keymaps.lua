-- Keymaps configuration

local map = vim.keymap.set

-- General Keymaps
-- Clear search highlights on <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })


-- Keep visual selection when indenting
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Tab management
map("n", "<leader>ta", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>te", [[:tabe <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "New tab in current dir" })

-- File operations in current directory
map("n", "<leader>e", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "Edit file in current dir" })
map("n", "<leader>s", [[:split <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false, desc = "Split in current dir" })

-- LSP keymaps (set on LspAttach autocmd)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		-- Navigation
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
		map("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, vim.tbl_extend("force", opts, { desc = "Goto definition (Telescope)" }))
		map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto declaration" }))
		map("n", "gi", function()
			require("telescope.builtin").lsp_implementations()
		end, vim.tbl_extend("force", opts, { desc = "Goto implementation (Telescope)" }))
		map("n", "go", function()
			require("telescope.builtin").lsp_type_definitions()
		end, vim.tbl_extend("force", opts, { desc = "Goto type definition (Telescope)" }))
		map("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, vim.tbl_extend("force", opts, { desc = "Goto references (Telescope)" }))
		map("n", "gs", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

		-- Actions & Refactoring
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		map("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
		map("n", "<F4>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))

		-- Diagnostics
		map("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
		map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
		map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

		-- Inlay hints toggle (Neovim 0.10+)
		if vim.lsp.inlay_hint then
			map("n", "<leader>th", function()
				local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
			end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
		end

		-- Document symbol highlighting on cursor hold
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", { bufnr = event.buf }) then
			local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. event.buf, { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp_detach_" .. event.buf, { clear = true }),
				buffer = event.buf,
				callback = function()
					vim.lsp.buf.clear_references()
					pcall(vim.api.nvim_del_augroup_by_name, "lsp_document_highlight_" .. event.buf)
				end,
			})
		end
	end,
})

-- Format (with conform.nvim)
map({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ lsp_format = "fallback", timeout_ms = 1000 })
end, { desc = "Format file or range" })

-- Session management
map("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "Session search" })
map("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
map("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete session" })

