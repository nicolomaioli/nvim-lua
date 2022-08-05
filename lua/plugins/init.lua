local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    Bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,'
                            .. vim.o.runtimepath
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.nvim-treesitter')
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('plugins.nvim-treesitter-textobjects')
        end
    }

    use 'nvim-treesitter/playground'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('plugins.telescope')
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        tag = 'nightly',
        config = function()
            require('plugins.nvim-tree')
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'L3MON4D3/LuaSnip'},
            {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'},
            {'hrsh7th/cmp-path', after = 'nvim-cmp'},
            {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
        },
        config = function()
            require('plugins.nvim-cmp')
        end

    }

    use {'hrsh7th/cmp-nvim-lsp'}

    use {
        'neovim/nvim-lspconfig',
        requires = {'hrsh7th/cmp-nvim-lsp'},
        config = function()
            require('plugins.nvim-lspconfig')
        end
    }

    use 'mhinz/vim-signify'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use {
        'tpope/vim-fugitive',
        config = function()
            require('plugins.vim-fugitive')
        end
    }

    use {'dracula/vim', as = 'dracula'}

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('plugins.lualine')
        end
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('plugins.nvim-autopairs')
        end
    }

    if Bootstrap then require('packer').sync() end
end)
