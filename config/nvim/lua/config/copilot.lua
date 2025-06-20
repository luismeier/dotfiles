return {
  "github/copilot.vim",
  config = function()
    -- vim.g.copilot_no_tab_map = true
    vim.g.copilot_no_tab_map = false

    -- Set up manual keybinding (change <C-l> if you prefer another key)
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
      noremap = true,
      replace_keycodes = false,
    })
  end,
}
