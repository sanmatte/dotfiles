return {
  "vyfor/cord.nvim",
  event = "VeryLazy", -- load it lazily
  config = function()
    require("cord").setup({
      -- Optional config
      client_id = nil, -- You can set a custom Discord Application ID here
      -- toggle to true to auto-start on launch
      auto_start = true,
      log_level = "info",
    })
  end,
}

