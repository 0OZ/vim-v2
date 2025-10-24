return {
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
            ["@number"] = { fg = "#98C379", bold = true },
            ["@float"] = { fg = "#98C379", bold = true },
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

                  -- Comments - Lower contrast green
            ["@comment"] = { fg = "#6A9955", italic = true },

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

      -- Additional highlight overrides for high contrast
      vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFFFF", bg = "#0D1117" })
      vim.api.nvim_set_hl(0, "Function", { fg = "#FFE66D", bold = true })
      vim.api.nvim_set_hl(0, "String", { fg = "#FFA657" })
      vim.api.nvim_set_hl(0, "Number", { fg = "#98C379", bold = true })
      vim.api.nvim_set_hl(0, "Identifier", { fg = "#66D9EF" })
      vim.api.nvim_set_hl(0, "Statement", { fg = "#FF6AC1", bold = true })
      vim.api.nvim_set_hl(0, "Type", { fg = "#00E8C6", bold = true })
      vim.api.nvim_set_hl(0, "Constant", { fg = "#36D0FF", bold = true })
      vim.api.nvim_set_hl(0, "Operator", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#6A9955", italic = true })

      -- Override UI elements to use lower contrast colors
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#66D9EF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#FFFFFF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "Pmenu", { fg = "#FFFFFF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#FFFFFF", bg = "#2D333B", bold = true })
      vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#66D9EF", bg = "#161B22" })

      -- Which-key specific overrides
      vim.api.nvim_set_hl(0, "WhichKey", { fg = "#FFE66D", bold = true })
      vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "#66D9EF" })
      vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = "#6A9955" })
      vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "#161B22" })
      vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = "#66D9EF", bg = "#161B22" })

      -- Fix buffer tabs/tabline colors
      vim.api.nvim_set_hl(0, "TabLine", { fg = "#66D9EF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#FFFFFF", bg = "#0D1117", bold = true })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#161B22" })

      -- Fix bufferline colors (if using bufferline.nvim)
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#161B22" })
      vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#66D9EF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "BufferLineBuffer", { fg = "#66D9EF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#FFFFFF", bg = "#0D1117", bold = true })
      vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = "#6A9955", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "BufferLineTab", { fg = "#66D9EF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = "#FFFFFF", bg = "#0D1117", bold = true })

      -- Fix Snacks.nvim picker/select UI (for file deletion confirmations, etc.)
      vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#FFFFFF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#FFE66D", bg = "#161B22", bold = true })
      vim.api.nvim_set_hl(0, "SnacksPickerItem", { fg = "#FFFFFF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "SnacksPickerItemSelected", { fg = "#FFFFFF", bg = "#2D333B", bold = true })
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#66D9EF", bg = "#161B22" })
      vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#FF6AC1", bold = true })

      -- General UI confirmations and messages
      vim.api.nvim_set_hl(0, "Title", { fg = "#FFE66D", bold = true })
      vim.api.nvim_set_hl(0, "Question", { fg = "#36D0FF", bold = true })
      vim.api.nvim_set_hl(0, "MoreMsg", { fg = "#98C379", bold = true })
    end,
  },
}
