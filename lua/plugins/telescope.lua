return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- FZF native for better performance
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		-- Setup telescope
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
				prompt_prefix = "🔍 ",
				selection_caret = "➜ ",
				path_display = { "truncate" },
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
				},
			},
		})

		-- Load fzf extension
		telescope.load_extension("fzf")

		-- Keymaps
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Grep string" })
	end,
}
