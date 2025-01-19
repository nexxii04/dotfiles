-- This file contains the configuration for various UI-related plugins in Neovim.
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#1a75ff" })

return {
    -- Plugin: noice.nvim
    -- URL: https://github.com/folke/noice.nvim
    -- Description: A Neovim plugin for enhancing the command-line UI.
    {
        "folke/noice.nvim",
        dependencies = {},
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                    signature = {
                        enabled = false,
                    },
                },
                cmdline = {
                    view = "cmdline", -- Use the cmdline view for the command-line
                    format = {
                        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                        -- view: (default is cmdline view)
                        -- opts: any options passed to the view
                        -- icon_hl_group: optional hl_group for the icon
                        -- title: set to anything or empty string to hide
                        cmdline = { pattern = "^:", icon = "", lang = "vim" },
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                        lua = {
                            pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                            icon = "",
                            lang = "lua",
                        },
                        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                        input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
                        -- lua = false, -- to disable a format, set to `false`
                    },
                },
                presets = {
                    bottom_search = true, -- Enable bottom search view
                    command_palette = true, -- Enable command palette view
                    lsp_doc_border = true, -- Enable LSP documentation border
                },
                -- Uncomment the following lines to customize the cmdline popup view
                -- views = {
                --   cmdline_popup = {
                --     filter_options = {},
                --     win_options = {
                --       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                --     },
                --   },
                -- },
            })
        end,
    },

    -- Plugin: nvim-docs-view
    -- URL: https://github.com/amrbashir/nvim-docs-view
    -- Description: A Neovim plugin for viewing documentation.
    {
        "amrbashir/nvim-docs-view",
        lazy = true, -- Load this plugin lazily
        cmd = "DocsViewToggle", -- Command to toggle the documentation view
        opts = {
            position = "right", -- Position the documentation view on the right
            width = 60, -- Set the width of the documentation view
        },
    },

    -- Plugin: lualine.nvim
    -- URL: https://github.com/nvim-lualine/lualine.nvim
    -- Description: A blazing fast and easy to configure Neovim statusline plugin.
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
        requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- Optional dependency for icons
        opts = {
            options = {
                theme = "catppuccin-mocha", -- Set the theme for lualine
                icons_enabled = true, -- Enable icons in the statusline
            },
            sections = {
                lualine_a = {
                    {
                        "mode", -- Display the current mode
                        icon = "󱗞", -- Set the icon for the mode
                    },
                },
            },
        },
    },

    -- Plugin: incline.nvim
    -- URL: https://github.com/b0o/incline.nvim
    -- Description: A Neovim plugin for showing the current filename in a floating window.
    {
        "b0o/incline.nvim",
        event = "BufReadPre", -- Load this plugin before reading a buffer
        priority = 1200, -- Set the priority for loading this plugin
        config = function()
            require("incline").setup({
                window = { margin = { vertical = 0, horizontal = 1 } }, -- Set the window margin
                hide = {
                    cursorline = true, -- Hide the incline window when the cursorline is active
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") -- Get the filename
                    if vim.bo[props.buf].modified then
                        filename = "[+] " .. filename -- Indicate if the file is modified
                    end

                    local icon, color = require("nvim-web-devicons").get_icon_color(filename) -- Get the icon and color for the file
                    return { { icon, guifg = color }, { " " }, { filename } } -- Return the rendered content
                end,
            })
        end,
    },

    -- Plugin: mini.nvim
    -- URL: https://github.com/echasnovski/mini.nvim
    -- Description: A collection of minimal, fast, and modular Lua plugins for Neovim.
    {
        "echasnovski/mini.nvim",
        version = false, -- Use the latest version
        config = function()
            require("mini.animate").setup({
                resize = {
                    enable = false, -- Disable resize animations
                },
                open = {
                    enable = false, -- Disable open animations
                },
                close = {
                    enable = false, -- Disable close animations
                },
                scroll = {
                    enable = false, -- Disable scroll animations
                },
            })
        end,
    },

    -- Plugin: zen-mode.nvim
    -- URL: https://github.com/folke/zen-mode.nvim
    -- Description: A Neovim plugin for distraction-free coding.
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode", -- Command to toggle Zen Mode
        opts = {
            plugins = {
                gitsigns = true, -- Enable gitsigns integration
                tmux = true, -- Enable tmux integration
                kitty = { enabled = false, font = "+2" }, -- Disable kitty integration and set font size
                twilight = { enabled = true }, -- Enable twilight integration
            },
        },
        keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } }, -- Keybinding to toggle Zen Mode
    },

    -- Plugin: snacks.nvim
    -- URL: https://github.com/folke/snacks.nvim/tree/main
    -- Description: A Neovim plugin for creating a customizable dashboard.
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },
                },
                preset = {
                    header = [[

                                                                    
      ████ ██████           █████      ██                     
     ███████████             █████                             
     █████████ ███████████████████ ███   ███████████   
    █████████  ███    █████████████ █████ ██████████████   
   █████████ ██████████ █████████ █████ █████ ████ █████   
 ███████████ ███    ███ █████████ █████ █████ ████ █████  
██████  █████████████████████ ████ ████ █████ ████ ██████ 



]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
                },
            },
        },
    },
}
