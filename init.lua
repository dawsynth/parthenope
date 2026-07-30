----------------------------------------Retrieve plugins--------------------------------------------
vim.pack.add({
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/mhartington/formatter.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
----------------------------------------Retrieve plugins--------------------------------------------

------------------------------------------Set options-----------------------------------------------
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
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Make tabs equivalent to 4 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Display 100 character column
vim.opt.colorcolumn = "100"

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Maintain minimum number of lines above and below cursor
vim.opt.scrolloff = 10

vim.opt.swapfile = false
vim.opt.winborder = "rounded"

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
------------------------------------------Set options-----------------------------------------------

--------------------------------------Plugin Configuration------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

require('nvim-treesitter').install { 'lua', 'cpp', 'python', 'rust' }
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        allTargets = false
      }
    }
  }
})
vim.lsp.enable({ "lua_ls", "clangd", "ty", "rust_analyzer" })

local util = require("formatter.util")

require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    -- Configuration for C++
    cpp = {
      function()
        return {
          exe = "clang-format-14",
          args = {
            "--assume-filename",
            util.escape_path(util.get_current_buffer_file_name()),
          },
          stdin = true,
        }
      end
    },
    -- You can add C here as well
    c = {
      function()
        return {
          exe = "clang-format-14",
          args = {
            "--assume-filename",
            util.escape_path(util.get_current_buffer_file_name()),
          },
          stdin = true,
        }
      end
    },
  },
})

require('nvim-web-devicons').setup { default = true; }

require("rose-pine").setup({
  variant = 'moon',
  disable_background = true,
  disable_italics = true,
})
vim.cmd("colorscheme rose-pine")
vim.cmd(":hi statusline guibg=NONE")
--------------------------------------Plugin Configuration------------------------------------------

--------------------------------------------Keymaps-------------------------------------------------
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

--- TELESCOPE ---
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
--- TELESCOPE ---
--------------------------------------------Keymaps-------------------------------------------------
