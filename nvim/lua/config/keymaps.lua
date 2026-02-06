-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim-tmux-navigator is configured in plugins/tmux-navigator.lua
-- This provides seamless navigation with Ctrl+hjkl between vim splits and tmux panes

-- Colemak Mod-DH window navigation (NEIU = left/down/up/right on nav layer)
-- Maps Alt+NEIU to window navigation (avoids Ctrl+I/E/U conflicts)
vim.keymap.set("n", "<M-n>", "<C-h>", { desc = "Go to left window" })
vim.keymap.set("n", "<M-e>", "<C-j>", { desc = "Go to lower window" })
vim.keymap.set("n", "<M-i>", "<C-k>", { desc = "Go to upper window" })
vim.keymap.set("n", "<M-u>", "<C-l>", { desc = "Go to right window" })
