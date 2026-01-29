-- Leader key is set in lazy.lua before plugin loading

-- Basic remaps
vim.keymap.set("n", "<leader>x", vim.cmd.Ex, { desc = "Open file explorer" })
-- Format + Save (Ctrl-s)
vim.keymap.set({ "n", "i" }, "<C-s>", function()
    -- leave insert mode so formatting doesn't fight your typing
    if vim.fn.mode() == "i" then
        vim.cmd.stopinsert()
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local filetype = vim.bo[bufnr].filetype

    -- File types that Prettier supports
    local prettier_filetypes = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        vue = true,
        css = true,
        scss = true,
        less = true,
        html = true,
        json = true,
        jsonc = true,
        yaml = true,
        markdown = true,
        graphql = true,
        handlebars = true,
    }

    -- Check if Prettier is available
    local prettier_available = vim.fn.executable("prettier") == 1
    local use_prettier = prettier_available and prettier_filetypes[filetype]

    if use_prettier and filepath ~= "" then
        -- Save the buffer first so Prettier formats the latest changes
        local ok, err = pcall(vim.cmd, "write")
        if not ok then
            vim.notify("Failed to save file: " .. tostring(err), vim.log.levels.ERROR)
            return
        end
        
        -- Check file size after saving (skip files > 1MB to prevent memory issues)
        local filesize = vim.fn.getfsize(filepath)
        local max_size = 1024 * 1024 -- 1MB in bytes
        
        if filesize > max_size then
            vim.notify(
                string.format("File too large for Prettier (%.1f MB). File saved but not formatted.", filesize / (1024 * 1024)),
                vim.log.levels.WARN
            )
            return
        end

        -- Use Prettier for formatting
        local stderr_output = {}
        local stderr_line_count = 0
        local max_stderr_lines = 10 -- Limit error output to prevent overwhelming popups
        
        vim.fn.jobstart({ "prettier", "--write", filepath }, {
            on_stderr = function(_, data)
                if data and stderr_line_count < max_stderr_lines then
                    for _, line in ipairs(data) do
                        if line and line ~= "" and stderr_line_count < max_stderr_lines then
                            table.insert(stderr_output, line)
                            stderr_line_count = stderr_line_count + 1
                        end
                    end
                end
            end,
            on_exit = function(_, exit_code)
                -- Check if buffer is still valid and matches the filepath
                if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) == filepath then
                    if exit_code == 0 then
                        -- Reload the buffer to show formatted content (using edit! to avoid W12 warnings)
                        -- Only reload if buffer hasn't been modified since we saved it
                        vim.api.nvim_buf_call(bufnr, function()
                            if not vim.bo[bufnr].modified then
                                vim.cmd("edit!")
                            else
                                vim.notify("Buffer was modified during formatting, skipping reload to preserve changes", vim.log.levels.WARN)
                            end
                        end)
                        vim.notify("Formatted with Prettier and saved", vim.log.levels.INFO)
                    else
                        -- Check for common error patterns and provide helpful messages
                        local error_msg = table.concat(stderr_output, "\n")
                        
                        if error_msg:match("[Hh]eap out of memory") or error_msg:match("FATAL ERROR") then
                            vim.notify(
                                "Prettier ran out of memory formatting this file.\n" ..
                                "File saved but not formatted.\n" ..
                                "Try formatting a smaller section or use LSP formatting instead.",
                                vim.log.levels.ERROR
                            )
                        elseif error_msg:match("SyntaxError") then
                            -- Extract just the syntax error line
                            local syntax_error = error_msg:match("(SyntaxError[^\n]*)")
                            vim.notify(
                                "Prettier formatting failed:\n" .. (syntax_error or "Syntax error in file"),
                                vim.log.levels.WARN
                            )
                        elseif #stderr_output > 0 then
                            -- Show truncated error for other failures
                            local display_msg = error_msg
                            if stderr_line_count >= max_stderr_lines then
                                display_msg = display_msg .. "\n... (error output truncated)"
                            end
                            vim.notify("File saved but Prettier formatting failed:\n" .. display_msg, vim.log.levels.WARN)
                        else
                            vim.notify("File saved but Prettier formatting failed (unknown error)", vim.log.levels.WARN)
                        end
                    end
                end
            end,
        })
    else
        -- Fall back to LSP formatting or just save
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        local can_format = false
        for _, c in ipairs(clients) do
            if c.supports_method("textDocument/formatting") then
                can_format = true
                break
            end
        end

        if can_format then
            -- Format synchronously, then write
            vim.lsp.buf.format({
                bufnr = bufnr,
                async = false,
                timeout_ms = 2000,
            })
            local ok, err = pcall(vim.cmd, "write")
            if not ok then
                vim.notify("Failed to save file: " .. tostring(err), vim.log.levels.ERROR)
            end
        else
            -- No formatter attached: just save
            vim.cmd("write")
        end
    end
end, { desc = "Format and save" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set({ "n", "i" }, "<C-q>", ":qa!<CR>", { desc = "Quit" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Better window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Paste without losing register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Quick substitute
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Quick substitute word" })

-- Make file executable
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- from primeagen tutorial - maybe replace these over time

-- ===================================
-- VSCode-like keybindings
-- ===================================

-- Ctrl-b: Toggle file browser (like VSCode's sidebar)
vim.keymap.set("n", "<C-b>", function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "Toggle file browser" })

vim.keymap.set("n", "<C-a>", "gg0vG$", { desc = "Select all" })

-- Ctrl-`: Toggle terminal (handled by toggleterm.nvim plugin)
-- Terminal opens as a panel at the bottom, doesn't create tabs
-- Multiple terminals can be created with different numbers (e.g., <leader>2 for terminal 2)

-- Ctrl-w: Close current buffer/file (override Neovim's default window command prefix)
-- This overrides Ctrl-w which is normally used as a prefix for window commands.
-- Essential window navigation is preserved with Ctrl-h/Ctrl-l and leader+w mappings below.
vim.keymap.set("n", "<C-w>", function()
    -- Check if buffer is modified (has unsaved changes)
    if vim.bo.modified then
        -- Prompt user with options
        local choice = vim.fn.confirm(
            "Save changes to " .. vim.fn.expand("%:t") .. "?",
            "&Save and close\n&Close without saving\nC&ancel",
            3 -- Default to Cancel
        )

        if choice == 1 then
            -- Save and close
            vim.cmd("write")
            vim.cmd("bdelete")
        elseif choice == 2 then
            -- Close without saving (discard changes)
            vim.cmd("bdelete!")
        end
        -- choice == 3 or 0 (ESC pressed) - do nothing (cancel)
    else
        -- No unsaved changes, close normally
        vim.cmd("bdelete")
    end
end, { desc = "Close buffer (with save prompt)" })

-- Restore essential window navigation that used Ctrl-w as prefix
-- Ctrl-h and Ctrl-l for left/right navigation are already set above (lines 10-11)
-- For up/down window navigation, use leader+w prefix (Alt-j/k is used for moving lines)
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close current window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })
-- Note: Vertical and horizontal splits are already mapped to <leader>sv and <leader>sh at lines 14-15
