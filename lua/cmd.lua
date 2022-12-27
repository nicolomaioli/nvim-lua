local cmd = vim.cmd
local api = vim.api
-- local colorscheme = require('colorschemes')

cmd('filetype plugin on')
cmd('syntax enable')
cmd('silent! helptags ALL')

-- Set transparent background in the terminal
if (vim.fn.has('gui_running') == 0) then
    api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end
