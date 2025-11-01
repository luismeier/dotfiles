return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers["*"] = opts.servers["*"] or {}
    opts.servers["*"].keys = opts.servers["*"].keys or {}

    table.insert(opts.servers["*"].keys, {
      "gV",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
      end,
      desc = "Open definition in split",
      has = "definition", -- only set if server supports it
    })
  end,
}
