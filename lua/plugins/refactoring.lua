return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup({})

		-- Keymaps for refactoring
		vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract function (visual)" })
		vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to file (visual)" })
		vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable (visual)" })
		vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var<CR>", { desc = "Inline variable" })
		vim.keymap.set("n", "<leader>rI", ":Refactor inline_func<CR>", { desc = "Inline function" })
		vim.keymap.set("n", "<leader>rb", ":Refactor extract_block<CR>", { desc = "Extract block" })
		vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file<CR>", { desc = "Extract block to file" })

		-- Prompt for return type for extracted function
		vim.keymap.set("x", "<leader>rr", function()
			require("refactoring").select_refactor()
		end, { desc = "Select refactor" })
	end,
}
