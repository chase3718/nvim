# Neovim Configuration

A modern, well-structured Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Features

- 🚀 **Fast startup** with lazy-loading plugins
- 🎨 **Rose Pine** color scheme
- 🔍 **Telescope** fuzzy finder with FZF native integration
- 🌳 **Treesitter** for advanced syntax highlighting
- 💼 **LSP Support** with auto-completion and diagnostics
- 📦 **Mason** for easy LSP server installation
- 🎯 **Harpoon** for quick file navigation
- ⏪ **Undotree** for undo history visualization
- 🔧 **Git integration** with vim-fugitive
- 🤖 **GitHub Copilot** support

## Requirements

- Neovim >= 0.9.0
- Git
- A C compiler (for telescope-fzf-native)
- Make (for telescope-fzf-native)
- Node.js (optional, for some LSP servers)
- Ripgrep (optional, for live grep in Telescope)

## Installation

1. Backup your existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. Clone this repository:
```bash
git clone https://github.com/chase3718/nvim.git ~/.config/nvim
```

3. Start Neovim:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## Structure

```
.
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   └── lazy.lua        # Lazy.nvim bootstrap and setup
│   ├── init.lua            # General Neovim settings
│   ├── plugins/            # Plugin specifications
│   │   ├── cmp.lua         # Autocompletion configuration
│   │   ├── copilot.lua     # GitHub Copilot
│   │   ├── harpoon.lua     # Quick file navigation
│   │   ├── lsp.lua         # LSP Zero base
│   │   ├── lspconfig.lua   # LSP server configurations
│   │   ├── mason.lua       # LSP/tool installer
│   │   ├── rose-pine.lua   # Color scheme
│   │   ├── telescope.lua   # Fuzzy finder
│   │   ├── treesitter.lua  # Syntax highlighting
│   │   ├── undotree.lua    # Undo history
│   │   └── vim-fugitive.lua # Git integration
│   └── remaps/
│       └── init.lua        # Key mappings
└── .gitignore
```

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>x` - Open file explorer
- `<C-s>` - Save file
- `jj` - Exit insert mode (in insert mode)
- `<C-q>` - Quit

### Telescope
- `<leader>ff` - Find files
- `<C-p>` - Find git files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags
- `<leader>ps` - Grep string (with input)

### LSP
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<leader>vd` - Open diagnostic float
- `[d` - Next diagnostic
- `]d` - Previous diagnostic
- `<leader>vca` - Code action
- `<leader>vrn` - Rename symbol
- `<C-h>` - Signature help (in insert mode)

### Harpoon
- `<leader>a` - Add file to harpoon
- `<C-e>` - Toggle harpoon quick menu
- `<C-j>` - Previous harpoon file
- `<C-k>` - Next harpoon file

### Git (Fugitive)
- `<leader>gs` - Git status

### Undotree
- `<leader>u` - Toggle undotree

### Completion (nvim-cmp)
- `<C-n>` - Next suggestion
- `<C-p>` - Previous suggestion
- `<C-Space>` - Complete
- `<CR>` - Confirm
- `<Tab>` - Next item / expand snippet
- `<S-Tab>` - Previous item / jump back in snippet

## LSP Servers

The following LSP servers are automatically installed via Mason:
- `lua_ls` - Lua
- `rust_analyzer` - Rust
- `clangd` - C/C++

To add more servers:
1. Open Mason: `:Mason`
2. Browse available servers
3. Press `i` to install

Or add them to the `servers` table in `lua/plugins/mason.lua`.

## Customization

### Adding Plugins

Create a new file in `lua/plugins/` with the plugin specification:

```lua
return {
    "author/plugin-name",
    config = function()
        -- Plugin configuration
    end,
}
```

### Changing Color Scheme

Edit `lua/plugins/rose-pine.lua` or replace it with your preferred theme.

### Adding Key Mappings

Add your custom mappings to `lua/remaps/init.lua`:

```lua
vim.keymap.set("n", "<leader>key", function()
    -- Your command
end, { desc = "Description" })
```

## Updating

Plugins are managed by lazy.nvim. To update:

1. Open Neovim
2. Run `:Lazy update`

## Troubleshooting

### Plugins not loading
Try `:Lazy sync` to reinstall all plugins.

### LSP not working
1. Check if the server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart the LSP: `:LspRestart`

### Treesitter parser errors
Update parsers: `:TSUpdate`

## License

This configuration is free to use and modify as you wish.
