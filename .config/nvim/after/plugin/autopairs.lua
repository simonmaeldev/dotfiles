-- Auto pairs configuration
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true, -- enable treesitter
    ts_config = {
        python = {'string'}, -- don't add pairs in python strings
    },
})

