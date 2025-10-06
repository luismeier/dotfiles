if true then
  return {}
else
  return {
    { "miversen33/netman.nvim" },
    {
      "jedrzejboczar/devcontainers.nvim",
      dependencies = {
        "nvim-lspconfig", -- for configuration using on_new_config hook
        "netman.nvim", -- optional to browse files in docker container
      },
      opts = {},
    },
  }
end
