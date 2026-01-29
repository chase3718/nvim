return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- Setup mason
		mason.setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Ensure these servers are installed
		local servers = {
			"lua_ls",
			"rust_analyzer",
			"clangd",
		}

		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		-- Setup LSP servers
		mason_lspconfig.setup_handlers({
			-- Default handler
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
			-- Server-specific handlers
			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
					settings = {
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
					},
				})
			end,
		})
	end,
}
