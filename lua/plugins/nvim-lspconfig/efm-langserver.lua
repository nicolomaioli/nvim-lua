local eslint = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'},
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true
}

local prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT}',
    formatStdin = true
}

local lua_format = {
    formatCommand = 'lua-format -i --chop-down-table --no-align-table-field --chop-down-kv-table --chop-down-parameter --no-align-parameter --no-align-args --double-quote-to-single-quote --no-use-tab --no-keep-simple-function-one-line --no-keep-simple-control-block-one-line --no-break-after-operator --column-limit=80 --break-after-table-lb',
    formatStdin = true
}

local python_black = {formatCommand = 'black --quiet -', formatStdin = true}

local M = {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.goto_definition = false
        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync{}')
    end,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    settings = {
        languages = {
            lua = {lua_format},
            javascript = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            css = {prettier},
            html = {prettier},
            json = {prettier},
            python = {python_black}
        }
    },
    filetypes = {
        'lua',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'css',
        'html',
        'json',
        'python'
    }
}

return M
