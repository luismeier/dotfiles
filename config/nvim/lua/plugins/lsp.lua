return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")

    -- Add your keymap
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = {
      "gV",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
      end,
      desc = "Open definition in split",
    }
  end,
}
