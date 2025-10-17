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
            -- Functions - Bright yellow
            ["@function"] = { fg = "#FFE66D", bold = true },
            ["@function.call"] = { fg = "#FFE66D", bold = true },
            ["@function.builtin"] = { fg = "#FFD700", bold = true },
            ["@method"] = { fg = "#FFE66D", bold = true },
            ["@method.call"] = { fg = "#FFE66D", bold = true },

            -- Strings - Bright orange
            ["@string"] = { fg = "#FFA657" },
            ["@string.escape"] = { fg = "#FFD700", bold = true },
            ["@character"] = { fg = "#FFA657" },

            -- Numbers - Bright light green
            ["@number"] = { fg = "#7FFF00", bold = true },
            ["@float"] = { fg = "#7FFF00", bold = true },
            ["@boolean"] = { fg = "#569CD6", bold = true },

            -- Variables - Bright light blue
            ["@variable"] = { fg = "#66D9EF" },
            ["@variable.builtin"] = { fg = "#569CD6", bold = true },
            ["@parameter"] = { fg = "#66D9EF" },

            -- Keywords - Bright purple/magenta
            ["@keyword"] = { fg = "#FF6AC1", bold = true },
            ["@keyword.function"] = { fg = "#FF6AC1", bold = true },
            ["@keyword.return"] = { fg = "#FF6AC1", bold = true },
            ["@keyword.operator"] = { fg = "#FF6AC1", bold = true },
            ["@conditional"] = { fg = "#FF6AC1", bold = true },
            ["@repeat"] = { fg = "#FF6AC1", bold = true },
            ["@include"] = { fg = "#FF6AC1", bold = true },
            ["@exception"] = { fg = "#FF6AC1", bold = true },

            -- Types - Bright cyan/teal
            ["@type"] = { fg = "#00E8C6", bold = true },
            ["@type.builtin"] = { fg = "#00E8C6", bold = true },
            ["@type.qualifier"] = { fg = "#569CD6", bold = true },
            ["@type.definition"] = { fg = "#00E8C6", bold = true },

            -- Constants - Bright blue
            ["@constant"] = { fg = "#36D0FF", bold = true },
            ["@constant.builtin"] = { fg = "#36D0FF", bold = true },

            -- Operators - Bright white
            ["@operator"] = { fg = "#FFFFFF" },

            -- Comments - Bright green
            ["@comment"] = { fg = "#87D96B", italic = true },

            -- Properties/Fields - Bright light blue
            ["@property"] = { fg = "#66D9EF" },
            ["@field"] = { fg = "#66D9EF" },

            -- Namespaces/Modules - Bright cyan
            ["@namespace"] = { fg = "#00E8C6", bold = true },
            ["@module"] = { fg = "#00E8C6", bold = true },

            -- Macros/Decorators - Bright yellow
            ["@attribute"] = { fg = "#FFD700" },
            ["@macro"] = { fg = "#FFD700", bold = true },

            -- Punctuation - White
            ["@punctuation.bracket"] = { fg = "#FFFFFF" },
            ["@punctuation.delimiter"] = { fg = "#FFFFFF" },

            -- Tags (HTML/JSX)
            ["@tag"] = { fg = "#FF6AC1", bold = true },
            ["@tag.attribute"] = { fg = "#66D9EF" },
            ["@tag.delimiter"] = { fg = "#FFFFFF" },
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
