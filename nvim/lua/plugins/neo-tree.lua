-- Neo-tree configuration to show hidden files including .env
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.filesystem = opts.filesystem or {}
    opts.filesystem.filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        ".git",
        "node_modules",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
    }
    return opts
  end,
}
