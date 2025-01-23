require("neotest").setup({
  adapters = {
    require("neotest-python")
  }
})

vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
