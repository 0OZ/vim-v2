return {
  -- Satellite: scrollbar with git, diagnostics, and search decorations
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
      current_only = false,
      winblend = 50,
      zindex = 40,
      excluded_filetypes = {},
      width = 2,
      handlers = {
        cursor = {
          enable = true,
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" },
        },
        gitsigns = {
          enable = true,
          signs = {
            add = "│",
            change = "│",
            delete = "-",
          },
        },
        marks = {
          enable = true,
          show_builtins = false,
        },
      },
    },
  },
}
