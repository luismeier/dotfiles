return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = {
      "g<tab>",
      function()
        vim.cmd("vsplit")
        Snacks.picker.lsp_definitions()
        -- vim.lsp.buf.definition()
      end,
      desc = "Open definition in split",
    }
  end,
}
