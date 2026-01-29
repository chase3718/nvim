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
		-- Only add lazygit keybinding if lazygit is installed
		if vim.fn.executable("lazygit") == 1 then
			vim.keymap.set("n", "<leader>gg", function()
				require("snacks").lazygit.open()
			end, { desc = "Lazygit" })
		end

		vim.keymap.set("n", "<leader>gb", function()
			require("snacks").git.blame_line()
		end, { desc = "Git Blame Line" })

		vim.keymap.set("n", "<leader>gB", function()
			require("snacks").git.browse()
		end, { desc = "Git Browse" })
	end,
}
