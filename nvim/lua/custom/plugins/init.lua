return {
  -- format & linting
  ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
  },
  ["sindrets/diffview.nvim"] = {
    after = "plenary.nvim",
    config = function()
      require("custom.plugins.diffview").setup()
    end,
  },
  ["nvim-lua/plenary.nvim"] = { module = "" },
  ["karb94/neoscroll.nvim"] = {
    config = function ()
      require("neoscroll").setup()
    end
  }
}
