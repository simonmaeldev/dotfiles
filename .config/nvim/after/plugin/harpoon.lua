local harpoon = require("harpoon")
harpoon.setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) * 0.8,
        height = vim.api.nvim_win_get_height(0) * 0.6,
        border = "rounded",
    }
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-r>", function() ui.nav_file(4) end)

