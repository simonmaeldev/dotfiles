-- Auto pairs configuration
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true, -- enable treesitter
    ts_config = {
        python = {'string'}, -- don't add pairs in python strings
    },
})

-- Add specific rules for Python
npairs.add_rules({
    Rule("(", ")", "python")
        :with_pair(function(opts)
            return vim.tbl_contains({'string'}, vim.tbo.get_current_node():type())
        end),
    Rule("[", "]", "python")
        :with_pair(function(opts)
            return vim.tbl_contains({'string'}, vim.tbo.get_current_node():type())
        end),
    Rule("{", "}", "python")
        :with_pair(function(opts)
            return vim.tbl_contains({'string'}, vim.tbo.get_current_node():type())
        end),
})
