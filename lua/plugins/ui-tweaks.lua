return {
  -- Disable animations in Noice
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      views = {
        notify = {
          replace = true, -- Disable notification animations
        },
      },
    },
  },

  -- Disable animations in Snacks (LazyVim's UI components)
  {
    "folke/snacks.nvim",
    opts = {
      animate = {
        enabled = false, -- Disable all animations
      },
      scroll = {
        enabled = false, -- Disable smooth scrolling entirely
      },
      indent = {
        animate = {
          enabled = false,
        },
      },
      notifier = {
        timeout = 3000,
      },
    },
  },

  -- Disable indent-blankline animations
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
}
