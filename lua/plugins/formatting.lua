return {
  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      },
      formatters = {
        biome = {
          command = "biome",
          args = { "check", "--write", "--unsafe", "--stdin-file-path", "$FILENAME" },
          stdin = true,
        },
      },
    },
  },
}
