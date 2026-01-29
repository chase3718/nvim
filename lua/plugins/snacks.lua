return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>gg", function()
			require("snacks").lazygit.open()
		end, { desc = "Lazygit" })

		vim.keymap.set("n", "<leader>gb", function()
			require("snacks").git.blame_line()
		end, { desc = "Git Blame Line" })

		vim.keymap.set("n", "<leader>gB", function()
			require("snacks").git.browse()
		end, { desc = "Git Browse" })
	end,
}
