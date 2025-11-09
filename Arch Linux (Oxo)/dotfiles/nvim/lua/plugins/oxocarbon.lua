return {
  -- add gruvbox
  { "nyoom-engineering/oxocarbon.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
