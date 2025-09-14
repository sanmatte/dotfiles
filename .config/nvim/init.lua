require("configs")
vim.g.python3_host_prog = vim.fn.exepath 'python3'
vim.g.loaded_python3_provider = nil
vim.cmd('runtime! plugin/rplugin.vim')

local project_path = vim.fn.expand("~/Github/unwhoop/*")

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = project_path,
  callback = function()
    local date = os.date("%Y-%m-%d")
    local year = os.date("%Y")
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
			"# Unwhoop",
      "# Created: " .. date,
      "# Copyright (c) " .. year .. "Matteo Sanna",
      ""
    })
  end
})

