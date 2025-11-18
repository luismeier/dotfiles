return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = true,
          debounce = 75,
        },
        panel = {
          enabled = false,
        },
      })
    end,
  },
  {
    "giuxtaposition/blink-cmp-copilot",
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
      },
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  --   specs = {
  --     {
  --       "hrsh7th/nvim-cmp",
  --       optional = true,
  --       ---@param opts cmp.ConfigSchema
  --       opts = function(_, opts)
  --         table.insert(opts.sources, 1, {
  --           name = "copilot",
  --           group_index = 2,
  --           priority = 100,
  --         })
  --       end,
  --     },
  --   },
  -- },
}
