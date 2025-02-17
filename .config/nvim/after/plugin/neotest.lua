require("neotest").setup({
  adapters = {
    require("neotest-python"),
  },
  -- Enable floating window for test output
  floating = {
    border = "rounded",
    max_height = 0.9,
    max_width = 0.9,
  },
  -- Enable statusline integration
  status = {
    enabled = true,
    signs = true,
    virtual_text = false,
  },
})

-- Add more comprehensive keymaps for testing
vim.keymap.set('n', '<leader>tn', function() 
  require('neotest').run.run() 
end, { desc = 'Run nearest test' })

vim.keymap.set('n', '<leader>tf', function() 
  require('neotest').run.run(vim.fn.expand('%')) 
end, { desc = 'Run current file tests' })

vim.keymap.set('n', '<leader>ts', function() 
  require('neotest').summary.toggle() 
end, { desc = 'Toggle test summary' })

vim.keymap.set('n', '<leader>td', function()
  require('neotest').run.run({ strategy = "dap" })
end, { desc = 'Debug nearest test' })

vim.keymap.set('n', '<leader>to', function()
  require('neotest').output.open({ enter = true })
end, { desc = 'Open test output' })
