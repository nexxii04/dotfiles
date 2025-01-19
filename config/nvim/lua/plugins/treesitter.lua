return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({

            ensure_installed = {
                "lua",
                "javascript",
                "typescript",
                "python",
                "go",
                "sql",
                "make",
                "dockerfile",
                "yaml",
                "graphql",
                "terraform",
                "proto",
                "html",
                "php",
                "cpp",
                "rust",
            },

            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })

        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }
    end,
}
