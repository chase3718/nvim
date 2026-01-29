return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- Enable indentation
			indent = {
				enable = true,
			},
			-- Automatically install parsers for new languages
			auto_install = true,
			-- List of languages to ensure are installed
			ensure_installed = {
				"javascript",
				"typescript",
				"lua",
				"vim",
				"vimdoc", -- Replaces deprecated "help" parser
				"json",
				"html",
				"python",
				"markdown",
				"markdown_inline",
			},
		})
	end,
}
