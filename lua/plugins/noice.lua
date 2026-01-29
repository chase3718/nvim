return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>nl", "<cmd>NoiceLast<CR>", { desc = "Noice Last Message" })
		vim.keymap.set("n", "<leader>nh", "<cmd>NoiceHistory<CR>", { desc = "Noice History" })
		vim.keymap.set("n", "<leader>na", "<cmd>NoiceAll<CR>", { desc = "Noice All" })
		vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss All" })
	end,
}
