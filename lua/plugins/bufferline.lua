return {
  -- Configure bufferline (tab UI)
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thin", -- Options: "slant", "slope", "thick", "thin", or { 'any', 'any' }
        indicator = {
          style = "none", -- Remove the indicator bar
        },
        -- Alternatively, use custom separators:
        -- separator_style = { "", "" }, -- No separators
        -- Or use different characters:
        -- separator_style = { "│", "│" },
      },
    },
  },
}
