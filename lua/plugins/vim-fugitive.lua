return {
	"tpope/vim-fugitive",
	version = "*",
	config = function()
		-- Open Git status in a new tab
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("tab Git")
		end, { desc = "Git status" })
	end,
}
