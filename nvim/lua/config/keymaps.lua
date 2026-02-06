-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim-tmux-navigator is configured in plugins/tmux-navigator.lua
-- This provides seamless navigation with Ctrl+hjkl between vim splits and tmux panes

-- Colemak Mod-DH window navigation (NEIU = left/down/up/right on nav layer)
-- Maps Ctrl+NEIU to window navigation (same as Ctrl+HJKL)
vim.keymap.set("n", "<C-n>", "<C-h>", { desc = "Go to left window" })
vim.keymap.set("n", "<C-e>", "<C-j>", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-i>", "<C-k>", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-u>", "<C-l>", { desc = "Go to right window" })
