-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Line numbering
local opt = vim.opt

-- Line numbering
opt.relativenumber = true
opt.number = true
opt.showtabline = 2

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = true
--opt.colorcolumn = "80"

-- Appearance
opt.termguicolors = true
--opt.background = "dark"
opt.signcolumn = "yes"

-- Alacritty
local alacrittyAutoGroup = vim.api.nvim_create_augroup("alacritty", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = alacrittyAutoGroup,
    callback = function()
        vim.fn.system(
            "alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false' 'window.opacity=0.0'"
        )
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    group = alacrittyAutoGroup,
    callback = function()
        vim.fn.jobstart("alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID -r", { detach = true })
    end,
})

vim.cmd([[
augroup kitty_mp
    autocmd!
    au VimLeave * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=20 margin=10
    au VimEnter * if !empty($KITTY_WINDOW_ID) | :silent !kitty @ set-spacing padding=0 margin=0
augroup END
]])

-- Blade
vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})
