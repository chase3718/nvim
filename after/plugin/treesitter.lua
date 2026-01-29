require("nvim-treesitter").setup({
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
        "json",
        "html",
        "python",
	"help",
    },
    -- Further module configurations can go here (e.g., textobjects)
    -- textobjects = { ... },
})

