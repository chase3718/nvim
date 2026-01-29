return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Configure nvim-treesitter with the new API
		require("nvim-treesitter").setup({
			-- Directory to install parsers and queries to
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install required parsers
		require("nvim-treesitter").install({
			"javascript",
			"typescript",
			"lua",
			"vim",
			"vimdoc",
			"json",
			"html",
			"python",
			"markdown",
			"markdown_inline",
			"bash",
			"regex",
		})

		-- Enable treesitter highlighting for common filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "typescript", "lua", "vim", "python", "html", "json", "markdown", "bash", "sh" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
