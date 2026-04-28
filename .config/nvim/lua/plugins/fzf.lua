return {
    "junegunn/fzf.vim",
    dependencies = {
        {
            "junegunn/fzf",
            build = "./install --bin",
        }
    },
    config = function()
        vim.keymap.set("n", "<leader>ff", ":Files<CR>", { silent = true, desc = "Find Files (FZF)" })
        vim.keymap.set("n", "<leader>fg", ":Rg<CR>", { silent = true, desc = "Ripgrep (FZF)" })
        vim.keymap.set("n", "<leader>fa", ":Ag<CR>", { silent = true, desc = "Silver Searcher (FZF)" })
    end,
}
