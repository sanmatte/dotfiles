return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")
        vim.keymap.set("n", "<leader>fa", fzf.live_grep, { silent = true, desc = "Live Grep (VS Code style)" })
        vim.keymap.set("n", "<leader>ff", fzf.files, { silent = true, desc = "Find Files" })
    end,
}
