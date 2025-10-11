return {
  { -- CSS colours
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  { -- Show historical versions of the file locally
    "mbbill/undotree",
  },
}
