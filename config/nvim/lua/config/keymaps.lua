-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- vim.keymap.set({ "n", "v" }, "<leader>\\", function()
--  require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
-- end)

-- maps.n["<leader>/"] = {
-- function() end,
--   desc = "Toggle comment line",
-- }
-- maps.v["<leader>/"] = {
--   "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
--   desc = "Toggle comment for selection",
-- }
vim.keymap.set("i", "jj", "<Esc>")
-- vim.keymap.set("n", "gds", ":vsplit| lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in new split" })
