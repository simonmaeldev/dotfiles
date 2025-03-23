require('lspconfig').pyright.setup{}

vim.keymap.set("n", "<leader>ai", require("lspimport").import, { noremap = true })
