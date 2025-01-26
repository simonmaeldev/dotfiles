require'mason-null-ls'.setup {
    ensure_installed = {
        'ruff',
        'prettier',
        'shfmt',
    },
    automatic_installation = true,
}

local null_ls = require 'null-ls'
local sources = {
    require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
    require('none-ls.formatting.ruff_format'),
    null_ls.builtins.diagnostics.ruff.with {
        command = 'ruff',
        args = {
            'check', 
            '--stdin-filename', '$FILENAME', 
            '-', 
            '--quiet',
            '--exit-zero'
        }
    },
    null_ls.builtins.formatting.prettier.with { filetypes = { 'json', 'yaml', 'markdown' } },
    null_ls.builtins.formatting.shfmt.with { args = { '-i', '4' } },
}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
null_ls.setup {
    debug = true, -- enable debug mode. Inspect logs with :NullLsLog
    sources = sources,
    update_in_insert = true, -- allow diagnostics to update as I type
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { async = false }
                end,
            })
        end
    end,
}
