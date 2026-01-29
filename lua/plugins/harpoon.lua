return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- Setup harpoon
		harpoon:setup()

		-- Keymaps
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon quick menu" })

		-- Navigate between harpoon marks
		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon previous" })
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():next()
		end, { desc = "Harpoon next" })
	end,
}
