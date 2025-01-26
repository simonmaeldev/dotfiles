require('refactoring').setup({
    prompt_func_return_type = {
        python = true
    },
    prompt_func_param_type = {
        python = true
    },
    show_success_message = true
})

vim.keymap.set("x", "<leader>re", ":Refactor extract ")
