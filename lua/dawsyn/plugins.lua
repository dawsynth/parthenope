local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
        "williamboman/mason.nvim",
        config = true,
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-lint',
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'folke/neodev.nvim',
    'catppuccin/nvim',
    'theprimeagen/vim-be-good',

}

local opts = {}

require("lazy").setup(plugins, opts)
