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
    require('none-ls.formatting.ruff').with { 
        extra_args = { 
            '--extend-select', 'I',  -- Enable isort rules
            '--fix'  -- Enable auto-fix
        } 
    },
    require('none-ls.formatting.ruff_format'),
    null_ls.builtins.diagnostics.ruff.with {
        command = 'ruff',
        args = {
            'check', 
            '--stdin-filename', '$FILENAME', 
            '-', 
            '--quiet',
            '--exit-zero',
            '--fix'  -- Enable auto-fix
        }
    },
    null_ls.builtins.formatting.prettier.with { filetypes = { 'json', 'yaml', 'markdown' } },
    null_ls.builtins.formatting.shfmt.with { args = { '-i', '4' } },
}

null_ls.setup {
    debug = true, -- enable debug mode. Inspect logs with :NullLsLog
    sources = sources,
    update_in_insert = true, -- allow diagnostics to update as I type
}
