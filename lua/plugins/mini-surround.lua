return {
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes (vim-surround style)
        delete = "ds", -- Delete surrounding (vim-surround style)
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "cs", -- Replace surrounding (vim-surround style)
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
}
