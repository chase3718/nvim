return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			preset = "modern",
			delay = 300,
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
			},
		})

		-- Register key groups
		wk.add({
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>h", group = "Hunk" },
			{ "<leader>s", group = "Split" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>v", group = "LSP" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>r", group = "Refactor" },
			{ "<leader>n", group = "Noice" },
		})
	end,
}
