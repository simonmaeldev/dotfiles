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
    require('none-ls.formatting.ruff_format'),
    null_ls.builtins.formatting.prettier.with { filetypes = { 'json', 'yaml', 'markdown' } },
    null_ls.builtins.formatting.shfmt.with { args = { '-i', '4' } },
}

null_ls.setup {
    debug = true,
    sources = sources,
    update_in_insert = false,  -- Disable diagnostics in insert mode
}
