return {
    'folke/tokyonight.nvim',
    lazy = false,
    enabled = false,
    config = function()
        require('tokyonight').setup({ style = 'storm' })
        vim.cmd.colorscheme('tokyonight')
    end,
}
