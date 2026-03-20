return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").terraformls.setup({})
      require("lspconfig").tflint.setup({})
    end,
  },
}
