vim.g.mapleader = " "

-- open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selected lines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- move selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- toggle undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- join lines but keep cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- scroll down and center
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- scroll up and center
vim.keymap.set("n", "<C-f>", "<C-u>zz")

-- next search result, center, and unfold
vim.keymap.set("n", "n", "nzzzv")

-- prev search result, center, and unfold
vim.keymap.set("n", "N", "Nzzzv")

-- paste without overwriting clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- copy line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- escape insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- disable ex mode
vim.keymap.set("n", "Q", "<nop>")

-- switch tmux session
-- vim.keymap.set("n", "<C-n>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- lsp code action
vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action)

-- reload file from disk
vim.keymap.set("n", "<leader>r", "e!")

-- next location list item
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- prev location list item
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Redo by pressing r in normal mode
-- redo
vim.keymap.set("n", "r", "<C-r>")
