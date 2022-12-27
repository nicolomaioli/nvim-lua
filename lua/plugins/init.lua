-- Indicate first time installation
local packer_bootstrap = false

-- packer.nvim configuration
local conf = {
    profile = {
        enable = true,
        -- the amount in ms that a plugins load time must be over for it to
        -- be included in the profile
        threshold = 0,
    },
}

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' ..
                             '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system {
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        }
        vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'
end

-- Plugins
local function plugins(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'nvim-treesitter/nvim-treesitter-context' },
            { 'nvim-treesitter/playground' },
        },
        run = ':TSUpdate',
        config = function()
            require('plugins.nvim-treesitter')
            require('plugins.nvim-treesitter-context')
        end,
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' }, -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' }, -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' }, -- Null-ls
            { 'jose-elias-alvarez/null-ls.nvim' },
            { 'nvim-lua/plenary.nvim' },
        },
        config = function()
            require('plugins.lsp')
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugins.telescope')
        end,
    }

    use {
        'mfussenegger/nvim-dap',
        ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        requires = { { 'rcarriga/nvim-dap-ui' },
                     { 'mxsdev/nvim-dap-vscode-js' } },
        config = function()
            require('plugins.dap')
        end,
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        tag = 'nightly',
        config = function()
            require('plugins.nvim-tree')
        end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('plugins.gitsigns-nvim')
        end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('plugins.comment-nvim')
        end,
    }

    use 'tpope/vim-surround'

    use {
        'tpope/vim-fugitive',
        config = function()
            require('plugins.vim-fugitive')
        end,
    }

    use {
        'folke/tokyonight.nvim',
        config = function()
            require('colorschemes.tokyonight')
        end,
    }

    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('colorschemes.catppuccin')
        end,
    }

    use {
        'ishan9299/nvim-solarized-lua',
        config = function()
            require('colorschemes.solarized')
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('plugins.lualine')
        end,
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('plugins.nvim-autopairs')
        end,
    }

    use {
        'akinsho/toggleterm.nvim',
        tag = '*',
        config = function()
            require('plugins.toggleterm-nvim')
        end,
    }

    use 'nicolomaioli/wtfm.nvim'

    -- Bootstrap Neovim
    if packer_bootstrap then
        print 'Restart Neovim required after installation!'
        require('packer').sync()
    end
end

packer_init()

local packer = require 'packer'
packer.init(conf)
packer.startup(plugins)
