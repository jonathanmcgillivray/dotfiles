-- vim-tmux-navigator: Seamless navigation between vim splits and tmux panes
-- Maps Ctrl+hjkl to navigate between vim splits and tmux panes transparently
return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (vim split or tmux pane)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (vim split or tmux pane)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (vim split or tmux pane)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (vim split or tmux pane)" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate to previous pane" },
    },
  },
}
