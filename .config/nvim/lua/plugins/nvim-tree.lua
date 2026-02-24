return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local nvim_tree = require("nvim-tree")
            local api = require("nvim-tree.api")

            -- nvim-tree requires setup to be called
            nvim_tree.setup({
                view = {
                    width = 30,
                    relativenumber = true,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
						vim.keymap.set("n", "<leader>h", api.tree.toggle)
        end
    },
}
