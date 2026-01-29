return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo", "LspInstall", "LspStart" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Get default capabilities for nvim-cmp integration
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Setup keybindings on LSP attach using LspAttach autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, remap = false }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
				vim.keymap.set("n", "gD", function()
					vim.lsp.buf.declaration()
				end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references()
				end, vim.tbl_extend("force", opts, { desc = "Go to references" }))
				vim.keymap.set("n", "gi", function()
					vim.lsp.buf.implementation()
				end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, vim.tbl_extend("force", opts, { desc = "Workspace symbol" }))
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next()
				end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, vim.tbl_extend("force", opts, { desc = "Code action" }))
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, vim.tbl_extend("force", opts, { desc = "References" }))
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, vim.tbl_extend("force", opts, { desc = "Rename" }))
				vim.keymap.set("i", "<C-k>", function()
					vim.lsp.buf.signature_help()
				end, vim.tbl_extend("force", opts, { desc = "Signature help" }))
			end,
		})

		-- Configure diagnostics
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Setup mason-lspconfig to automatically configure servers installed by Mason
		local mason_lspconfig = require("mason-lspconfig")

		-- Get list of installed servers
		local servers = mason_lspconfig.get_installed_servers()

		-- Configure each installed server using native vim.lsp.config API
		for _, server_name in ipairs(servers) do
			-- Skip non-LSP tools like stylua and codebook
			if server_name == "stylua" or server_name == "codebook" then
				goto continue
			end

			local config = {
				capabilities = capabilities,
			}

			-- Custom configuration for lua_ls
			if server_name == "lua_ls" then
				config.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				}
			end

			-- Use native vim.lsp.config API (Neovim 0.11+)
			vim.lsp.config(server_name, config)
			vim.lsp.enable(server_name)

			::continue::
		end
	end,
}
