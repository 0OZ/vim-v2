return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "lua",
        "python",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "json",
        "html",
        "css",
        "go",
        "rust",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },

  -- GitHub theme with high contrast
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
          hide_end_of_buffer = false,
          hide_nc_statusline = false,
          dim_inactive = false,
        },
        groups = {
          all = {
            -- Functions - VSCode yellow (like in JS/TS)
            ["@function"] = { fg = "#DCDCAA" },
            ["@function.call"] = { fg = "#DCDCAA" },
            ["@function.builtin"] = { fg = "#DCDCAA" },
            ["@method"] = { fg = "#DCDCAA" },
            ["@method.call"] = { fg = "#DCDCAA" },

            -- Strings - VSCode orange-brown
            ["@string"] = { fg = "#CE9178" },
            ["@string.escape"] = { fg = "#D7BA7D" },
            ["@character"] = { fg = "#CE9178" },

            -- Numbers - VSCode light green
            ["@number"] = { fg = "#B5CEA8" },
            ["@float"] = { fg = "#B5CEA8" },
            ["@boolean"] = { fg = "#569CD6" },

            -- Variables - VSCode light blue
            ["@variable"] = { fg = "#9CDCFE" },
            ["@variable.builtin"] = { fg = "#569CD6" },
            ["@parameter"] = { fg = "#9CDCFE" },

            -- Keywords - VSCode purple/blue
            ["@keyword"] = { fg = "#C586C0" },
            ["@keyword.function"] = { fg = "#C586C0" },
            ["@keyword.return"] = { fg = "#C586C0" },
            ["@keyword.operator"] = { fg = "#C586C0" },
            ["@conditional"] = { fg = "#C586C0" },
            ["@repeat"] = { fg = "#C586C0" },
            ["@include"] = { fg = "#C586C0" },
            ["@exception"] = { fg = "#C586C0" },

            -- Types - VSCode cyan/teal
            ["@type"] = { fg = "#4EC9B0" },
            ["@type.builtin"] = { fg = "#4EC9B0" },
            ["@type.qualifier"] = { fg = "#569CD6" },
            ["@type.definition"] = { fg = "#4EC9B0" },

            -- Constants - VSCode bright blue
            ["@constant"] = { fg = "#4FC1FF" },
            ["@constant.builtin"] = { fg = "#569CD6" },

            -- Operators - VSCode default white/light
            ["@operator"] = { fg = "#D4D4D4" },

            -- Comments - VSCode green
            ["@comment"] = { fg = "#6A9955", italic = true },

            -- Properties/Fields - VSCode light blue
            ["@property"] = { fg = "#9CDCFE" },
            ["@field"] = { fg = "#9CDCFE" },

            -- Namespaces/Modules - VSCode cyan
            ["@namespace"] = { fg = "#4EC9B0" },
            ["@module"] = { fg = "#4EC9B0" },

            -- Macros/Decorators
            ["@attribute"] = { fg = "#4EC9B0" },
            ["@macro"] = { fg = "#569CD6" },

            -- Punctuation
            ["@punctuation.bracket"] = { fg = "#D4D4D4" },
            ["@punctuation.delimiter"] = { fg = "#D4D4D4" },

            -- Tags (HTML/JSX)
            ["@tag"] = { fg = "#569CD6" },
            ["@tag.attribute"] = { fg = "#9CDCFE" },
            ["@tag.delimiter"] = { fg = "#808080" },
          },
        },
      })

      vim.cmd("colorscheme github_dark_default")

      -- Additional highlight overrides to match VSCode Dark+
      vim.api.nvim_set_hl(0, "Normal", { fg = "#D4D4D4", bg = "#1E1E1E" })
      vim.api.nvim_set_hl(0, "Function", { fg = "#DCDCAA" })
      vim.api.nvim_set_hl(0, "String", { fg = "#CE9178" })
      vim.api.nvim_set_hl(0, "Number", { fg = "#B5CEA8" })
      vim.api.nvim_set_hl(0, "Identifier", { fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "Statement", { fg = "#C586C0" })
      vim.api.nvim_set_hl(0, "Type", { fg = "#4EC9B0" })
      vim.api.nvim_set_hl(0, "Constant", { fg = "#4FC1FF" })
      vim.api.nvim_set_hl(0, "Operator", { fg = "#D4D4D4" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#6A9955", italic = true })
    end,
  },

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
