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

-- these keep the cursor in the middle when scrolling with ctrl d and u
-- from https://github.com/ThePrimeagen/init.lua
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- and these are for searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- tab keymaps
vim.keymap.set("n", "<leader><tab>N", ":tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader><tab>n", ":tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader><tab>p", ":tabprevious<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader><tab><tab>", ":tabprevious<cr>", { desc = "Switch to last tab" })

-- Keymaps to show documentation
vim.keymap.set("n", "<leader>?", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show documentation" })
