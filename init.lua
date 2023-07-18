-- Disable auto highlights of searched terms
vim.opt.hlsearch = false
-- Complete search
vim.opt.incsearch = true

-- Relative Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Sync clipboard between OS and neovim
vim.opt.clipboard = 'unnamedplus'

-- Indent wrapped lines as much as initial line
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Make tabs equivalent to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Display 80 character column
vim.opt.colorcolumn = "80"

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Maintain minimum number of lines above and below cursor
vim.opt.scrolloff = 10

